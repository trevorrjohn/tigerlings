#!/bin/bash
source ./tools/tb_function.sh

# In the previous exercise, we used TigerBeetle to rate-limit the number of requests to a service.
# Now, let's rate-limit the bandwidth usage of a user.

tb "create_accounts id=3200 code=10 ledger=320,
                    id=3201 code=10 ledger=320 flags=debits_must_not_exceed_credits;"

# Let's say we want to limit each user to 10 MB per minute.
# Instead of transferring an amount representing the number of requests, we'll transfer an amount representing the number of bytes.
MB_LIMIT=10000000
tb "create_transfers id=32000 debit_account_id=3200 credit_account_id=3201 amount=$MB_LIMIT ledger=320 code=10;"

TIMEOUT=2
# Let's say that the user is sending requests that are 1 MB each.
for ((i=1; i<=11; i++)); do
    id=$((32000 + i))
    # What should the amount be?
    amount="$(echo "$MB_LIMIT / 10" | bc)"
    tb "create_transfers id=${id} debit_account_id=3201 credit_account_id=3200 amount=${amount} timeout=$TIMEOUT ledger=320 code=10 flags=pending;"
done

# As before, if you want to test that the balance resets, you can uncomment the following lines to sleep for $TIMEOUT seconds before creating the last transfer.
sleep $TIMEOUT
tb "create_transfers id=32012 debit_account_id=3201 credit_account_id=3200 amount=10000000 timeout=$TIMEOUT ledger=320 code=10 flags=pending;"
