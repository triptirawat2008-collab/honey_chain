// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

contract HoneyChain {

    // =========================
    // 1. BEEKEEPER
    // =========================

    struct Beekeeper {
        string beekeeperId;
        string status;
        bool exists;
    }

    mapping(string => Beekeeper) public beekeepers;


    // =========================
    // 2. COMPANY
    // =========================

    struct Company {
        string licenseNumber;
        string companyName;
        string licenseStatus;
        uint256 issueDate;
        uint256 expiryDate;
        string issuingAuthority;
        bool exists;
    }

    mapping(string => Company) public companies;


    // =========================
    // 3. APIARY
    // =========================

    struct Apiary {
        string locationId;
        string beekeeperId;
        bool exists;
    }

    mapping(string => Apiary) public apiaries;


    // =========================
    // 4. HARVEST
    // =========================

    struct Harvest {
        string harvestId;
        string beekeeperId;
        string locationId;
        string harvestDate;
        string flowerSources;
        uint256 quantityKg;
        string labUlr;
        string ulrStatus;
        bool exists;
    }

    mapping(string => Harvest) public harvests;


    // =========================
    // 5. BATCH
    // =========================

    struct Batch {
        string batchId;
        string companyLicense;
        string productName;
        uint256 quantityKg;
        string finalLabUlr;
        string ulrStatus;
        string manualReportStatus;
        bool isLabCertified;
        bool manualReportCertified;
        uint256 createdAt;
        bool exists;
    }

    mapping(string => Batch) public batches;


    // =========================
    // 6. BATCH → HARVEST
    // =========================

    mapping(string => string[]) private batchHarvests;


    // =========================
    // 7. LAB REPORT
    // =========================

    struct LabReport {
        string ulrNumber;
        string labId;
        string labName;
        string nablCertificateNumber;
        string accreditationStatus;
        string reportNumber;
        string reportDate;
        string sampleId;
        bool exists;
    }

    mapping(string => LabReport) public labReports;


    // =========================
    // 8. HEALTH LOG
    // =========================

    struct HealthLog {
        string logId;
        string locationId;
        string status;
        string inspectionDate;
        bool exists;
    }

    mapping(string => HealthLog) public healthLogs;


    // =========================
    // EVENTS
    // =========================

    event BeekeeperRegistered(
        string beekeeperId
    );

    event CompanyRegistered(
        string licenseNumber
    );

    event ApiaryRegistered(
        string locationId
    );

    event HarvestRegistered(
        string harvestId,
        string beekeeperId
    );

    event BatchCreated(
        string batchId
    );

    event HarvestAddedToBatch(
        string batchId,
        string harvestId
    );

    event LabReportRegistered(
        string ulrNumber
    );

    event HealthLogRegistered(
        string logId
    );


    // =========================
    // FUNCTIONS
    // =========================

    function registerBeekeeper(
        string memory _beekeeperId,
        string memory _status
    ) public {

        require(
            !beekeepers[_beekeeperId].exists,
            "Beekeeper already exists"
        );

        beekeepers[_beekeeperId] = Beekeeper(
            _beekeeperId,
            _status,
            true
        );

        emit BeekeeperRegistered(_beekeeperId);
    }


    function registerCompany(
        string memory _licenseNumber,
        string memory _companyName,
        string memory _licenseStatus,
        uint256 _issueDate,
        uint256 _expiryDate,
        string memory _issuingAuthority
    ) public {

        require(
            !companies[_licenseNumber].exists,
            "Company already exists"
        );

        companies[_licenseNumber] = Company(
            _licenseNumber,
            _companyName,
            _licenseStatus,
            _issueDate,
            _expiryDate,
            _issuingAuthority,
            true
        );

        emit CompanyRegistered(_licenseNumber);
    }


    function registerApiary(
        string memory _locationId,
        string memory _beekeeperId
    ) public {

        require(
            beekeepers[_beekeeperId].exists,
            "Beekeeper does not exist"
        );

        require(
            !apiaries[_locationId].exists,
            "Apiary already exists"
        );

        apiaries[_locationId] = Apiary(
            _locationId,
            _beekeeperId,
            true
        );

        emit ApiaryRegistered(_locationId);
    }


    function registerHarvest(
        string memory _harvestId,
        string memory _beekeeperId,
        string memory _locationId,
        string memory _harvestDate,
        string memory _flowerSources,
        uint256 _quantityKg,
        string memory _labUlr,
        string memory _ulrStatus
    ) public {

        require(
            beekeepers[_beekeeperId].exists,
            "Beekeeper does not exist"
        );

        require(
            apiaries[_locationId].exists,
            "Apiary does not exist"
        );

        require(
            !harvests[_harvestId].exists,
            "Harvest already exists"
        );

        harvests[_harvestId] = Harvest(
            _harvestId,
            _beekeeperId,
            _locationId,
            _harvestDate,
            _flowerSources,
            _quantityKg,
            _labUlr,
            _ulrStatus,
            true
        );

        emit HarvestRegistered(
            _harvestId,
            _beekeeperId
        );
    }


    function createBatch(
        string memory _batchId,
        string memory _companyLicense,
        string memory _productName,
        uint256 _quantityKg,
        string memory _finalLabUlr,
        string memory _ulrStatus,
        string memory _manualReportStatus,
        bool _isLabCertified,
        bool _manualReportCertified
    ) public {

        require(
            !batches[_batchId].exists,
            "Batch already exists"
        );

        batches[_batchId] = Batch(
            _batchId,
            _companyLicense,
            _productName,
            _quantityKg,
            _finalLabUlr,
            _ulrStatus,
            _manualReportStatus,
            _isLabCertified,
            _manualReportCertified,
            block.timestamp,
            true
        );

        emit BatchCreated(_batchId);
    }


    function addHarvestToBatch(
        string memory _batchId,
        string memory _harvestId
    ) public {

        require(
            batches[_batchId].exists,
            "Batch does not exist"
        );

        require(
            harvests[_harvestId].exists,
            "Harvest does not exist"
        );

        batchHarvests[_batchId].push(_harvestId);

        emit HarvestAddedToBatch(
            _batchId,
            _harvestId
        );
    }


    function registerLabReport(
        string memory _ulrNumber,
        string memory _labId,
        string memory _labName,
        string memory _nablCertificateNumber,
        string memory _accreditationStatus,
        string memory _reportNumber,
        string memory _reportDate,
        string memory _sampleId
    ) public {

        require(
            !labReports[_ulrNumber].exists,
            "Lab report already exists"
        );

        labReports[_ulrNumber] = LabReport(
            _ulrNumber,
            _labId,
            _labName,
            _nablCertificateNumber,
            _accreditationStatus,
            _reportNumber,
            _reportDate,
            _sampleId,
            true
        );

        emit LabReportRegistered(_ulrNumber);
    }


    function registerHealthLog(
        string memory _logId,
        string memory _locationId,
        string memory _status,
        string memory _inspectionDate
    ) public {

        require(
            apiaries[_locationId].exists,
            "Apiary does not exist"
        );

        require(
            !healthLogs[_logId].exists,
            "Health log already exists"
        );

        healthLogs[_logId] = HealthLog(
            _logId,
            _locationId,
            _status,
            _inspectionDate,
            true
        );

        emit HealthLogRegistered(_logId);
    }


    // =========================
    // GET HARVESTS OF A BATCH
    // =========================

    function getBatchHarvests(
        string memory _batchId
    ) public view returns (string[] memory) {

        return batchHarvests[_batchId];
    }
}