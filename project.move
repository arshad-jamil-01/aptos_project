module MyModule::TokenizedGovernance {

    use aptos_framework::signer;
    use std::vector;

    /// Struct representing a proposal and the votes.
    struct Proposal has store, key {
        description: vector<u8>,  // Description of the proposal
        yes_votes: u64,           // Number of "Yes" votes
        no_votes: u64,            // Number of "No" votes
    }

    /// Function to create a new governance proposal.
    public fun create_proposal(creator: &signer, description: vector<u8>) {
        let proposal = Proposal {
            description,
            yes_votes: 0,
            no_votes: 0,
        };
        move_to(creator, proposal);
    }

    /// Function for token holders to vote on a proposal (1 for "Yes", 0 for "No").
    public fun vote_on_proposal(voter: &signer, proposal_creator: address, vote: u8) acquires Proposal {
        let proposal = borrow_global_mut<Proposal>(proposal_creator);

        // Vote: 1 means "Yes", 0 means "No"
        if (vote == 1) {
            proposal.yes_votes = proposal.yes_votes + 1;
        } else {
            proposal.no_votes = proposal.no_votes + 1;
        }
    }
}
