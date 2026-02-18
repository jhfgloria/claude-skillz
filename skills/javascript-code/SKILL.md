This skill defines JavaScript coding patterns and style conventions for Node.js backend services.

## File Structure

### Strict Mode
Always start files with:
```javascript
'use strict';
```

### Import Organization
Organize imports in logical groups with clear separation:
1. Node.js built-in modules
2. Third-party npm packages
3. Local modules (models, utilities, libraries)

```javascript
'use strict';

// Node.js built-ins
const url = require('url');
const zlib = require('zlib');

// Third-party packages
const moment = require('moment');
const uuid = require('uuid');
const Bluebird = require('bluebird');
const { boolean } = require('boolean');
const { encrypt } = require('@company/crypto-utils');

// Local modules
const Order = require('../models/order');
const Item = require('../models/item');
const { AppError } = require('../errors');
const log = require('../log')({ filename: __filename });
```

## Documentation

### JSDoc Comments
Use comprehensive JSDoc comments for all exported functions, classes, and complex types:

```javascript
/**
 * HTTP handler for canceling an order.
 * @param {import('express').Request & import('../../../middleware/context/context').ApiRequest} request
 * @param {import('express').Response} response
 * @returns {Promise<void>}
 */
async function cancelOrder (request, response) {
    // Implementation
}

/**
 * @typedef RetryStrategy
 * @property {number} maxAttempts e.g. 3
 * @property {number[]} retryableErrors e.g. [408, 500, 502, 503, 504]
 * @property {number} retryInterval in milliseconds e.g. 100
 */

/**
 * Archive subscriptions. Instead of deleting them permanently they
 * are kept for audit as archived.
 * @param subscriptionService
 * @param subscriptions List of subscriptions to update
 * @returns {Promise<*>} List of archived subscriptions
 */
async function archiveSubscriptions (subscriptionService, subscriptions) {
    const subscriptionIDs = subscriptions.map(sub => sub.id);
    return subscriptionService.bulkToggleArchived(subscriptionIDs, true);
}
```

### Inline Comments
Use inline comments to explain complex logic or business rules, not obvious code:
```javascript
// add the processed item to the batch that should be cleared from cache
cacheClearBatch.add(itemId);
```

## Function Patterns

### Naming Conventions
- Use descriptive, action-oriented names starting with verbs
- Common prefixes: `ensure*`, `find*`, `get*`, `generate*`, `create*`, `validate*`
- camelCase for functions and variables
- PascalCase for classes and constructors
- UPPER_SNAKE_CASE for constants

```javascript
// Good function names
async function findOrder (orderID, accountID) { }
function ensureOrderExists (order) { }
async function ensureUserCanCancelOrder (order, user, context) { }
function generateInvoiceData ({ customerId, lineItems }) { }
```

### Function Style
- Prefer named functions over arrow functions for top-level exports
- Use async/await over callbacks or raw promises
- Keep functions focused on a single responsibility
- Extract helper functions for clarity

```javascript
// Main handler delegates to focused helpers
async function cancelOrder (request, response) {
    const { orderID } = request.params;
    const { error: validationError, value: requestBody } = validateCancelOrder(request.body);

    if (validationError) {
        throw new AppError(
            'Request body is invalid',
            AppError.Codes.BAD_REQUEST,
            { errors: (validationError.details || []).map(detail => detail.message), cause: validationError }
        );
    }

    const [user, accountID] = findUserAndAccountInRequest(request);
    const order = await findOrder(orderID, accountID);

    ensureOrderExists(order);
    ensureOrderIsPending(order);
    ensureOrderIsNotShipped(order);
    await ensureUserCanCancelOrder(order, user, request.context);

    await processOrderCancellation(order, requestBody.reason, request.context);
    response.status(204).send();
}

// Focused helper functions
function findUserAndAccountInRequest (request) {
    const { accountID, userID } = identifyUserFromAuthData(request);
    const { user } = getContextItems({ accountID, userID });
    return [user, accountID];
}

function ensureOrderExists (order) {
    if (!order) { throw new AppError('Order not found', AppError.Codes.NOT_FOUND); }
}
```

### Guard Clauses and Early Returns
Use guard clauses for validation and error handling:

```javascript
function ensureOrderIsPending (order) {
    if (order.isCompleted) { throw new AppError('Order already completed', AppError.Codes.BAD_REQUEST); }
}

function ensureOrderIsNotShipped (order) {
    if (order.hasShipped) { throw new AppError('Cannot cancel shipped order', AppError.Codes.BAD_REQUEST); }
}
```

## Error Handling

### Use Custom Error Classes
Throw descriptive errors with proper error codes and context:

```javascript
const { AppError } = require('../errors');

if (!order) {
    throw new AppError('Order not found', AppError.Codes.NOT_FOUND);
}

if (validationError) {
    throw new AppError(
        'Request body is invalid',
        AppError.Codes.BAD_REQUEST,
        { errors: (validationError.details || []).map(detail => detail.message), cause: validationError }
    );
}

throw new AppError(
    `Failed to ${options.method} ${url}`,
    AppError.Codes.INTERNAL_SERVER_ERROR,
    { cause: error }
);
```

### Error Logging
Log errors with context before throwing or handling:

```javascript
this.logger.error({ error }, `EXTERNAL CALL: Failed request to ${url}`);
this.logger.warn({ body: text }, `Received error response from ${finalUrl} status="${response.status}"`);
```

## Asynchronous Patterns

### Prefer async/await
```javascript
async function processOrder (order) {
    const items = await order.getLineItems();
    await finalizeOrder(order, paymentMethod, context);
    return items;
}
```

### Use Bluebird for Advanced Promise Operations
```javascript
const Bluebird = require('bluebird');

// Parallel processing
const results = await Bluebird.map(items, async (item) => {
    return processItem(item);
}, { concurrency: 5 });
```

### Retry Logic
```javascript
const retry = require('bluebird-retry');

const retryableRequest = this._buildRequestWithRetry(finalUrl, options, retryStrategy);
const { response, text, json } = await retry(retryableRequest, {
    max_tries: retryStrategy?.maxAttempts || 1,
    interval: retryStrategy?.retryInterval || 100,
    maxInterval: 15000,
    backoff: (Math.random() * 0.5) + 1.5, // random backoff multiplier between 1.5-2x
    throw_original: true
});
```

## Code Organization

### Class Structure
```javascript
class HttpClient {
    /**
     * @class HttpClient
     * @param {{ [key: string]: string }} authHeaders
     * @param {{ headers?: Object, connection?: Object } | null} [forwardedRequest]
     * @param {{ logger?: import('bunyan').Logger }} [options]
     */
    constructor (authHeaders, forwardedRequest = null, { logger } = {}) {
        this._authHeaders = authHeaders;
        this._forwardedRequest = forwardedRequest;
        this.logger = logger || genericLogger;
    }

    /**
     * Runs a request to the given URL with the given options
     * @param {string} requestUrl
     * @param {{ method?: string, body?: string | null, query?: Object, headers?: Object }} [requestOptions]
     * @param {RetryStrategy|null} [retryStrategy]
     * @returns {Promise<{response: import('node-fetch').Response, json: JSON | null, text: string | null}>}
     */
    async runRequest (requestUrl, requestOptions = { method: 'GET', body: null }, retryStrategy = null) {
        // Implementation
    }

    /**
     * Private helper methods use underscore prefix
     * @private
     */
    _generateHeaders () {
        // Implementation
    }
}
```

### Module Exports
```javascript
// Single export
module.exports = cancelOrder;

// Multiple exports
module.exports = {
    archiveSubscriptions,
    activateSubscriptions
};

// Named exports for testing
exports.Order = require('../../models/order');
exports.TABLENAME = TABLENAME;
```

## Testing Patterns

### Test File Structure
```javascript
'use strict';

const expect = require('chai').expect;
const assert = require('node:assert');
const sinon = require('sinon');
const nock = require('nock');
const uuid = require('uuid');

describe('PaymentServiceClient', () => {
    let paymentServiceClient;
    let stubConfig;

    before(async () => {
        // Setup that runs once before all tests
    });

    after(async () => {
        // Cleanup that runs once after all tests
    });

    beforeEach(async () => {
        // Setup before each test
        stubConfig = setupStubPaymentService({
            accountID,
            apiClient: new ApiClient(mockGateway, {})
        });
    });

    afterEach(async () => {
        // Cleanup after each test
        nock.cleanAll();
        stubConfig.restore();
    });

    describe('when configured with auth header', () => {
        it('should proxy headers', async () => {
            // Arrange
            const paymentID = uuid.v4();
            nock(paymentServiceBaseUrl, { reqheaders: headersMatch })
                .get(`/payments/${paymentID}`)
                .reply(200, payment);

            // Act
            const result = await paymentServiceClient.getPaymentDetails(paymentID);

            // Assert
            expect(result).to.deep.equal(expectedPayment);
        });

        it('should return a 404 if order does not exist', async () => {
            const response = await apiClient.cancelOrder({ orderID: 'INVALID' });
            expect(response.statusCode).to.equal(404);
            expect(response.body).to.deep.equal({ error: { message: 'Order not found' } });
        });
    });
});
```

### Test Naming
- Use descriptive test names that explain the scenario and expected outcome
- Start with `should` for behavior tests
- Include context in nested describe blocks

```javascript
describe('Orders Router: Cancel Order Endpoint', () => {
    describe('When payment has not been processed', () => {
        it('should mark pending items as canceled', async () => {
            // Test implementation
        });

        it('should return a 401 if user is unauthenticated', async () => {
            // Test implementation
        });
    });
});
```

### Mocking and Stubbing
```javascript
// HTTP mocking with nock
nock(paymentServiceBaseUrl, { reqheaders: authHeaders })
    .get(`/payments/${paymentID}`)
    .reply(200, payment);

// Sinon stubs
const quotaMock = sinon.stub(QuotaService.prototype, 'getQuotas')
    .resolves({ limits: [] });

// Cleanup
quotaMock.restore();
```

## Constants and Configuration

### Define Constants at Module Level
```javascript
const ORDER_STATUSES = require('../lib/order_statuses');
const ORDER_PROCESSING_LATENCY_METRIC = 'order.processing.latency.msec';
const MAX_COMPRESSED_DATA_SIZE = Math.pow(2, 18); // 262 KB, half of max item size

exports.MAX_COMPRESSED_DATA_SIZE = MAX_COMPRESSED_DATA_SIZE;
```

### Environment Variables
```javascript
const { getEnvironmentVariable } = require('./util/environment');

const baseUrl = getEnvironmentVariable('PAYMENT_SERVICE_BASE_URL');
const debugMode = boolean(getEnvironmentVariable('ENABLE_DEBUG_LOGGING'));
```

## Data Transformation

### Use Functional Array Methods
```javascript
const subscriptionIDs = subscriptions.map(sub => sub.id);

const processedLineItems = lineItems
    .filter(item => !(isPendingItem(item) && item.quantity))
    .map(item => ({
        displayName: toItemName(item),
        sku: generateSKU(toItemName(item)),
        type: item.type,
        quantity: (item || {}).quantity
    }));
```

### Destructuring
```javascript
// Parameter destructuring
async function runRequest (requestUrl, requestOptions = { method: 'GET', body: null }, retryStrategy = null) {
    const { method, body: requestBody, query, headers: requestHeaders } = requestOptions;
}

// Return value destructuring
const { error: validationError, value: requestBody } = validateCancelOrder(request.body);
const [user, accountID] = findUserAndAccountInRequest(request);
```

## Logging

### Use Structured Logging
```javascript
const log = require('../log')({ filename: __filename });

this.logger.warn({ body: text }, `Received error response from ${finalUrl} status="${response.status}"`);
this.logger.error({ error }, `EXTERNAL CALL: Failed request to ${url}`);
this._debug(`Issuing ${method} request for ${finalUrl}`, requestBody, options.headers);
```

## Summary

Key principles to follow:
1. Write clear, self-documenting code with descriptive names
2. Use small, focused functions with single responsibilities
3. Document public APIs with JSDoc
4. Handle errors explicitly with custom error classes
5. Prefer async/await for asynchronous code
6. Write comprehensive tests with clear scenarios
7. Use guard clauses for validation
8. Keep code DRY but prefer clarity over cleverness
9. Log errors and important events with context
10. Follow consistent naming conventions throughout
