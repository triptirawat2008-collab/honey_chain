// Synthetic Registries representing official registrations for HoneyChain SIH Prototype

export const BEEKEEPER_REGISTRY = {
  "BK-SYN-00001": {
    beekeeperId: "BK-SYN-00001",
    registeredName: "Ravi Kumar",
    state: "Uttar Pradesh",
    status: "ACTIVE",
  },
  "BK-SYN-00002": {
    beekeeperId: "BK-SYN-00002",
    registeredName: "Amit Singh",
    state: "Rajasthan",
    status: "ACTIVE",
  },
  "BK-SYN-00003": {
    beekeeperId: "BK-SYN-00003",
    registeredName: "Neha Sharma",
    state: "Bihar",
    status: "EXPIRED",
  },
  "BK-SYN-00004": {
    beekeeperId: "BK-SYN-00004",
    registeredName: "Rajesh Patel",
    state: "Gujarat",
    status: "SUSPENDED",
  }
};

export const LICENSE_REGISTRY = {
  "LIC-SYN-00001": {
    licenseNumber: "LIC-SYN-00001",
    companyName: "ABC Honey Pvt Ltd",
    state: "Uttar Pradesh",
    status: "ACTIVE",
  },
  "LIC-SYN-00002": {
    licenseNumber: "LIC-SYN-00002",
    companyName: "Himalayan Organics",
    state: "Uttarakhand",
    status: "ACTIVE",
  },
  "LIC-SYN-00003": {
    licenseNumber: "LIC-SYN-00003",
    companyName: "PureSweet Processors",
    state: "Punjab",
    status: "EXPIRED",
  }
};

export const LAB_REGISTRY = {
  "LAB-SYN-00001": {
    labReference: "LAB-SYN-00001",
    labName: "Demo Honey Testing Laboratory",
    status: "ACTIVE",
  },
  "LAB-SYN-00002": {
    labReference: "LAB-SYN-00002",
    labName: "National Honey Analytics",
    status: "ACTIVE",
  },
  "LAB-SYN-00003": {
    labReference: "LAB-SYN-00003",
    labName: "Apex Food Quality Lab",
    status: "ACTIVE",
  }
};

// Initial Seed Data for the prototype
export const INITIAL_HARVESTS = [
  {
    harvestId: "HB-BK0001-20260820-01",
    beekeeperId: "BK-SYN-00001",
    beekeeperName: "Ravi Kumar",
    harvestDate: "2026-08-20",
    flowerSources: ["Mustard", "Multifloral"],
    locationId: "LOC-001",
    locationName: "Apiary 1 - Rampur, UP",
    labName: "Demo Honey Testing Laboratory",
    labReference: "LAB-SYN-00001",
    labReportName: "lab_report_mustard_ramp.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    hash: "a2f8c8d3e91120f260820b12a819c99187a28e37d04e5f72cf91a38cfbc76a91",
    previousHash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    txRef: "0x8fa3f2c5d9e501a2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6",
    timestamp: "2026-08-20T10:15:30Z"
  },
  {
    harvestId: "HB-BK0001-20260824-02",
    beekeeperId: "BK-SYN-00001",
    beekeeperName: "Ravi Kumar",
    harvestDate: "2026-08-24",
    flowerSources: ["Eucalyptus"],
    locationId: "LOC-001",
    locationName: "Apiary 1 - Rampur, UP",
    labName: "Demo Honey Testing Laboratory",
    labReference: "LAB-SYN-00001",
    labReportName: "lab_report_euc_ramp.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    hash: "b5e9f1a27e3d8f9c1a5b8e9d0c2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e",
    previousHash: "a2f8c8d3e91120f260820b12a819c99187a28e37d04e5f72cf91a38cfbc76a91",
    txRef: "0x9ab3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3",
    timestamp: "2026-08-24T14:30:00Z"
  },
  {
    harvestId: "HB-BK0002-20260823-01",
    beekeeperId: "BK-SYN-00002",
    beekeeperName: "Amit Singh",
    harvestDate: "2026-08-23",
    flowerSources: ["Acacia"],
    locationId: "LOC-002",
    locationName: "Apiary 2 - Alwar, Rajasthan",
    labName: "National Honey Analytics",
    labReference: "LAB-SYN-00002",
    labReportName: "lab_report_acacia_alwar.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    hash: "c3d7e8b9a0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7",
    previousHash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    txRef: "0x12a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3",
    timestamp: "2026-08-23T09:45:00Z"
  }
];

export const INITIAL_BATCHES = [
  {
    batchId: "BT-LIC001-20260825-01",
    companyName: "ABC Honey Pvt Ltd",
    licenseNumber: "LIC-SYN-00001",
    productName: "Raw Organic Honey Blend",
    batchQuantity: "750 kg",
    processingInfo: "Cold-filtered and blended for consistent moisture control.",
    createdDate: "2026-08-25",
    labName: "Demo Honey Testing Laboratory",
    labReference: "LAB-SYN-00001",
    labReportName: "batch_lab_report_01.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    sourceHarvestIds: ["HB-BK0001-20260820-01", "HB-BK0001-20260824-02", "HB-BK0002-20260823-01"],
    hash: "fa2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c0d1e2f",
    previousHash: "c3d7e8b9a0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7",
    txRef: "0xbc51a4e67f89c0b1a2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5",
    timestamp: "2026-08-25T17:10:00Z"
  }
];

export const INITIAL_APIARIES = [
  {
    locationId: "LOC-001",
    name: "Apiary 1 - Rampur East",
    gps: "28.8041, 79.0250",
    hiveCount: 12,
    status: "Healthy",
    lastInspection: "2026-08-25"
  },
  {
    locationId: "LOC-002",
    name: "Apiary 2 - Moradabad Hills",
    gps: "28.8372, 78.7749",
    hiveCount: 8,
    status: "Needs Attention",
    lastInspection: "2026-08-23"
  }
];

export const INITIAL_HEALTH_LOGS = [
  {
    id: "HL-001",
    locationId: "LOC-001",
    date: "2026-08-20",
    status: "Healthy",
    affectedColonies: 0,
    notes: "All colonies verified active and producing well. Queen present in all boxes."
  },
  {
    id: "HL-002",
    locationId: "LOC-002",
    date: "2026-08-23",
    status: "Needs Attention",
    affectedColonies: 3,
    notes: "Minor wasp activity observed near colony boxes 2 and 5. Set up traps."
  },
  {
    id: "HL-003",
    locationId: "LOC-001",
    date: "2026-08-25",
    status: "Healthy",
    affectedColonies: 0,
    notes: "Routine inspection complete. Honey stores look plentiful, no signs of pests."
  }
];

export const INITIAL_REMINDERS = [
  {
    id: "RM-001",
    title: "Check Wasp Traps at LOC-002",
    date: "2026-08-28",
    notes: "Inspect the wasp traps set up on Aug 23. Replenish bait if necessary.",
    status: "Pending"
  },
  {
    id: "RM-002",
    title: "Prepare Extraction Equipment",
    date: "2026-08-30",
    notes: "Sterilize extractors and frames for the upcoming mustard crop harvest.",
    status: "Pending"
  },
  {
    id: "RM-003",
    title: "Check Honey Quality lab reports",
    date: "2026-08-26",
    notes: "Download official report for harvest HB-BK0001-20260824-02",
    status: "Completed"
  }
];

export const INITIAL_HISTORY = [
  {
    id: "H-001",
    timestamp: "2026-08-20T10:15:30Z",
    type: "Harvest Created",
    details: "Created Harvest HB-BK0001-20260820-01 (Mustard/Multifloral) from Apiary 1."
  },
  {
    id: "H-002",
    timestamp: "2026-08-20T11:00:00Z",
    type: "Health Log Added",
    details: "Added health status log for LOC-001: Healthy."
  },
  {
    id: "H-003",
    timestamp: "2026-08-23T09:30:00Z",
    type: "Health Log Added",
    details: "Added health status log for LOC-002: Needs Attention (Wasp activity)."
  },
  {
    id: "H-004",
    timestamp: "2026-08-24T14:30:00Z",
    type: "Harvest Created",
    details: "Created Harvest HB-BK0001-20260824-02 (Eucalyptus) from Apiary 1."
  },
  {
    id: "H-005",
    timestamp: "2026-08-25T12:00:00Z",
    type: "Location Updated",
    details: "Updated GPS location of LOC-001 to 28.8041, 79.0250 following apiary movement."
  }
];

// Helper to simulate cryptographic SHA-256 hash generation
export function generateMockHash(inputString) {
  let hash = 0;
  for (let i = 0; i < inputString.length; i++) {
    const char = inputString.charCodeAt(i);
    hash = (hash << 5) - hash + char;
    hash = hash & hash; // Convert to 32bit integer
  }
  // Convert to hex and pad to look like a real hash
  const hex = Math.abs(hash).toString(16).repeat(8).substring(0, 64);
  return hex;
}
