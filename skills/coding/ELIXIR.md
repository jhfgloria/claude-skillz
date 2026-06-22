### General
- Use function overloading as prime design pattern.
- Use `with` for composition.
- Prefer `case` over `if`, unless is a `true`-`false` binary.

#### `with` flattening
- Build on top of `with` for error compact error handling.

**Example:**
```elixir
with(
  {:ok, person} <- maybe_find_person(params.person_id),
  {:ok, initial_result, detail} <- process_enrollment(person, params),
  {:ok, _final_result, detail} <- maybe_resolve_duplicate(initial_result, detail, person),
  {:ok} <- finalize_enrollment(person, detail)
) do
  {:ok, detail}
else
  {:ok, result, detail} -> {result, detail}
  {:error, result, detail} -> {result, detail}
  {:error, :permanent_error} -> ...
  {:error, :temporary_error} -> ...
  {:error, :not_found} -> ...
  {:error, :person_fetch_error} -> ...
end
```

#### Pattern-matching as guard logic
- Use as much patter-matching as possible for overloading.
- Use function guards as pattern-matching for overloading.

**Example:**
```elixir
defp maybe_archive_person(
        %{
          source_key: "ext:" <> _,
          person_id: person_id,
          account_id: account_id
        },
        %ResponseDetail{
          body: body,
          status_code: 404
        }
      )
      when not is_nil(person_id) and not is_nil(account_id) do
  # only runs for ext: sources, 404 responses, with both IDs present
  case Jason.decode(body) do
    {:ok, %{"action" => "archive_person"}} ->
      PersonService.archive(account_id, person_id)
      ...
    _ -> :ok
  end
end

defp maybe_archive_person(_person, _detail), do: :ok
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
