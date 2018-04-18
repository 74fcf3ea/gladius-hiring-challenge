pragma solidity ^0.4.21;

contract gladius_simulator {
    struct Application {
        bool exists;
        string applicationData;
    }

    address private owner;
    string private publicKey;
    string private publicData;
    string private encryptedData;
    mapping(address => Application) private applications;
    address[] private applicants;

    function gladius_simulator(string _publicKey, string _publicData,
                               string _encryptedData) public {
        owner = msg.sender;
        publicKey = _publicKey;
        publicData = _publicData;
        encryptedData = _encryptedData;
    }

    function getPublicKey() public view returns (string) {
        return publicKey;
    }

    function getPublicData() public view returns (string) {
        return publicData;
    }

    function getEncryptedData() public view returns (string) {
        return encryptedData;
    }

    function submitApplication(string _applicationData) public {
        if (!applications[msg.sender].exists) {
            applicants.push(msg.sender);
            applications[msg.sender].exists = true;
        }
        applications[msg.sender].applicationData = _applicationData;
    }

    function getApplicants() public view returns (address[]) {
        return applicants;
    }

    function getApplication(address _applicant) public view returns (string) {
        require(applications[_applicant].exists);
        return applications[_applicant].applicationData;
    }

    function setPublicKey(string _publicKey) public {
        require(msg.sender == owner);
        publicKey = _publicKey;
    }

    function setPublicData(string _publicData) public {
        require(msg.sender == owner);
        publicData = _publicData;
    }

    function setEncryptedData(string _encryptedData) public {
        require(msg.sender == owner);
        encryptedData = _encryptedData;
    }

    function clearApplications() public {
        require(msg.sender == owner);
        for (uint i = 0; i < applicants.length; i++) {
            delete applications[applicants[i]];
        }
        delete applicants;
    }
}
