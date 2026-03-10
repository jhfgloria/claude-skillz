---
name: coding-elixir
description: Writes best practices for writing clean, maintainable Elixir code.
---

### Model
- Use Sonnet 4.6 for this skill

### Write Self-Explaining Code
- Never add explanatory comments unless absolutely necessary.
- Code should be clear enough to understand without comments.
- Use descriptive variable and function.

### Style of code

### General
- Use function overloading as prime design pattern.
- Use `with` for composition.
- Prefer `case` over `if`, unless is a `true`-`false` binary.

#### `with` flattening
- Build on top of `with` for error compact error handling.

**Example:**
```elixir
with(
  {:ok, access_token} <- maybe_get_oauth_access_token(webhook.oauth_client_id),
  {:ok, initial_result, delivery_detail} <- process_webhook_request(webhook, access_token),
  {:ok, _final_result, delivery_detail} <- maybe_handle_oauth_unauthorized(initial_result, delivery_detail, webhook),
  {:ok} <- process_successful_response(webhook, delivery_detail)
) do
  {:ok, delivery_detail}
else
  {:ok, result, delivery_detail} -> {result, delivery_detail}
  {:error, result, delivery_detail} -> {result, delivery_detail}
  {:error, :permanent_error} -> ...
  {:error, :temporary_error} -> ...
  {:error, :tls_alert} -> ...
  {:error, :oauth_client_token_fetch_error} -> ...
end
```

#### Pattern-matching as guard logic
- Use as much patter-matching as possible for overloading.
- Use function guards as pattern-matching for overloading.

**Example:**
```elixir
defp maybe_delete_subscription(
        %{
          integration_key: "app:" <> _,
          webhook_subscription_id: subscription_id,
          account_id: account_id
        },
        %DeliveryDetail{
          response_body: response_body,
          response_status_code: 404
        }
      )
      when not is_nil(subscription_id) and not is_nil(account_id) do
  # only runs for app: integrations, 404 responses, with both IDs present
  case Jason.decode(response_body) do
    {:ok, %{"operation" => "delete_subscription"}} ->
      WCSInteractor.delete_subscription(account_id, subscription_id)
      ...
    _ -> :ok
  end
end

defp maybe_delete_subscription(_webhook, _delivery_detail), do: :ok
```

#### Unused patter-matching terms
- Avoid using `_` to mark unused pattern-matching terms.
- Prefer prefixing the real term name with `_`.

**Good:**
```elixir
fn _id, name, _age, _address, _email -> ... end
```

**Good:**
```elixir
{:ok, _person} = Person.find(1)
```

**Bad:**
```elixir
fn _, name, _, _, _ -> ... end
```

**Bad:**
```elixir
{:ok, _} = Person.find(1)
```
