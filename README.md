 SubCheck Smart Contract

SubCheck is a decentralized subscription verification smart contract built on the Stacks blockchain. It allows service providers to register, manage, and verify subscription statuses of users in a transparent and immutable way.

 Features

- **Register Subscription:**  
Service providers can register subscription plans for users, specifying expiration blocks and associated fees.

- **Verify Subscription:**  
Allows anyone to verify whether a subscriber currently holds an active subscription.

- **Renew Subscription:**  
Subscribers can renew their subscription by paying the predefined fee, extending their subscription period.

- **Read Subscription Details:**  
Fetch detailed subscription records including expiration block and status.

 Functions

| Function | Access | Description |
| -------- | ------ | ----------- |
| `register-subscription` | Public | Register a new subscription plan for a user. |
| `verify-subscription` | Read-only | Check if a subscriber has an active subscription. |
| `renew-subscription` | Public | Allows a subscriber to renew their subscription. |
| `get-subscription-details` | Read-only | Retrieve complete details of a subscription. |

## Usage

1. **Deploy the Contract:**  
Deploy `subcheck.clar` to the Stacks blockchain using Clarinet or the Stacks CLI.

2. **Register a Subscription:**  
Service providers call `register-subscription` to onboard users.

3. **Verify Subscription Status:**  
Anyone can call `verify-subscription` to confirm if a subscription is active.

4. **Renew a Subscription:**  
Subscribers call `renew-subscription` and provide the required fee to extend their subscription.

 Requirements

- Stacks Blockchain
- Clarity smart contract language
- Clarinet (for local testing)

 Installation for Local Development

```bash
git clone https://github.com/yourusername/subcheck.git
cd subcheck
clarinet test
