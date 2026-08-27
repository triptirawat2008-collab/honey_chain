// Synthetic Registries representing official registrations for HoneyChain SIH Prototype

export const BEEKEEPER_REGISTRY = {
  "BK-SYN-00001": {
    beekeeperId: "BK-SYN-00001",
    registeredName: "Ravi Kumar (रवि कुमार)",
    association: "UP Beekeeper Association (उत्तर प्रदेश मधुमक्खी पालक संघ)",
    village: "Village Loni / Rampur",
    district: "Rampur / Ghaziabad",
    state: "Uttar Pradesh",
    hiveCount: 24,
    phone: "+91 98765 43210",
    status: "ACTIVE",
    registrationDate: "2024-03-15",
    avatar: "🧑‍🌾"
  },
  "BK-SYN-00002": {
    beekeeperId: "BK-SYN-00002",
    registeredName: "Amit Singh (अमित सिंह)",
    association: "Rajasthan Honey FPO (राजस्थान हनी कृषक उत्पादक कंपनी)",
    village: "Village Behror",
    district: "Alwar",
    state: "Rajasthan",
    hiveCount: 35,
    phone: "+91 98123 45678",
    status: "ACTIVE",
    registrationDate: "2023-11-20",
    avatar: "👨‍🌾"
  },
  "BK-SYN-00003": {
    beekeeperId: "BK-SYN-00003",
    registeredName: "Neha Sharma (नेहा शर्मा)",
    association: "Bihar Litchi Honey Co-op",
    village: "Kanti",
    district: "Muzaffarpur",
    state: "Bihar",
    hiveCount: 18,
    phone: "+91 97654 32109",
    status: "EXPIRED",
    registrationDate: "2022-05-10",
    avatar: "👩‍🌾"
  },
  "BK-SYN-00004": {
    beekeeperId: "BK-SYN-00004",
    registeredName: "Rajesh Patel (राजेश पटेल)",
    association: "Anand Apiary Producers",
    village: "Mogri",
    district: "Anand",
    state: "Gujarat",
    hiveCount: 12,
    phone: "+91 96543 21098",
    status: "SUSPENDED",
    registrationDate: "2023-01-18",
    avatar: "🧑‍🌾"
  }
};

export const LICENSE_REGISTRY = {
  "LIC-SYN-00001": {
    licenseNumber: "LIC-SYN-00001",
    companyName: "ABC Honey Producers Pvt Ltd",
    fssaiNumber: "FSSAI 10021051000124",
    state: "Uttar Pradesh",
    district: "Noida / Ghaziabad",
    contactPerson: "Vikram Malhotra",
    status: "ACTIVE",
    validTill: "2028-12-31"
  },
  "LIC-SYN-00002": {
    licenseNumber: "LIC-SYN-00002",
    companyName: "Himalayan Organics Co-operative",
    fssaiNumber: "FSSAI 10022061000452",
    state: "Uttarakhand",
    district: "Dehradun",
    contactPerson: "Sunita Negi",
    status: "ACTIVE",
    validTill: "2027-08-15"
  },
  "LIC-SYN-00003": {
    licenseNumber: "LIC-SYN-00003",
    companyName: "PureSweet Processors & Exporters",
    fssaiNumber: "FSSAI 10019011000876",
    state: "Punjab",
    district: "Ludhiana",
    contactPerson: "Harpreet Gill",
    status: "EXPIRED",
    validTill: "2025-06-30"
  }
};

export const LAB_REGISTRY = {
  "LAB-SYN-00001": {
    labReference: "LAB-SYN-00001",
    labName: "Demo Honey Testing Laboratory (NABL #104)",
    accreditation: "ISO/IEC 17025:2017 & NABL Accredited",
    location: "Ghaziabad, Uttar Pradesh",
    status: "ACTIVE"
  },
  "LAB-SYN-00002": {
    labReference: "LAB-SYN-00002",
    labName: "National Honey Analytics & Purity Center",
    accreditation: "National Accreditation Board for Testing (NABL)",
    location: "Pune, Maharashtra",
    status: "ACTIVE"
  },
  "LAB-SYN-00003": {
    labReference: "LAB-SYN-00003",
    labName: "Apex Food Quality & NMR Testing Lab",
    accreditation: "FSSAI Referral Laboratory",
    location: "New Delhi",
    status: "ACTIVE"
  }
};

// Initial Seed Data for the prototype
export const INITIAL_HARVESTS = [
  {
    harvestId: "HB-BK0001-20260820-01",
    beekeeperId: "BK-SYN-00001",
    beekeeperName: "Ravi Kumar (रवि कुमार)",
    state: "Uttar Pradesh",
    harvestDate: "2026-08-20",
    flowerSources: ["Mustard", "Multifloral"],
    flowerSourcesHi: ["सरसों", "बहुपुष्पी"],
    locationId: "LOC-001",
    locationName: "Apiary 1 - Rampur Mustard Belt (रामपुर सरसों क्षेत्र)",
    gps: "28.8041° N, 79.0250° E",
    labName: "Demo Honey Testing Laboratory (NABL #104)",
    labReference: "LAB-SYN-00001",
    labReportName: "lab_report_mustard_ramp.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    moisture: "17.2%",
    hmf: "12.4 mg/kg",
    c4Sugar: "Negative (Pass)",
    pollenCount: "18,500 grains/g",
    hash: "a2f8c8d3e91120f260820b12a819c99187a28e37d04e5f72cf91a38cfbc76a91",
    previousHash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    blockNumber: 148918,
    txRef: "0x8fa3f2c5d9e501a2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5b6",
    timestamp: "2026-08-20T10:15:30Z",
    quantityKg: 180
  },
  {
    harvestId: "HB-BK0001-20260824-02",
    beekeeperId: "BK-SYN-00001",
    beekeeperName: "Ravi Kumar (रवि कुमार)",
    state: "Uttar Pradesh",
    harvestDate: "2026-08-24",
    flowerSources: ["Eucalyptus"],
    flowerSourcesHi: ["यूकेलिप्टस / सफेदा"],
    locationId: "LOC-001",
    locationName: "Apiary 1 - Rampur East (रामपुर पूर्व)",
    gps: "28.8041° N, 79.0250° E",
    labName: "Demo Honey Testing Laboratory (NABL #104)",
    labReference: "LAB-SYN-00001",
    labReportName: "lab_report_euc_ramp.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    moisture: "17.6%",
    hmf: "14.1 mg/kg",
    c4Sugar: "Negative (Pass)",
    pollenCount: "16,200 grains/g",
    hash: "b5e9f1a27e3d8f9c1a5b8e9d0c2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e",
    previousHash: "a2f8c8d3e91120f260820b12a819c99187a28e37d04e5f72cf91a38cfbc76a91",
    blockNumber: 148919,
    txRef: "0x9ab3c4d5e6f7a8b9c0d1e2f3a4b5c6d7e8f9a0b1c2d3e4f5a6b7c8d9e0f1a2b3",
    timestamp: "2026-08-24T14:30:00Z",
    quantityKg: 140
  },
  {
    harvestId: "HB-BK0002-20260823-01",
    beekeeperId: "BK-SYN-00002",
    beekeeperName: "Amit Singh (अमित सिंह)",
    state: "Rajasthan",
    harvestDate: "2026-08-23",
    flowerSources: ["Acacia"],
    flowerSourcesHi: ["किकर / बबूल"],
    locationId: "LOC-002",
    locationName: "Apiary 2 - Alwar Hills (अलवर पहाड़ियां)",
    gps: "27.5530° N, 76.6346° E",
    labName: "National Honey Analytics & Purity Center",
    labReference: "LAB-SYN-00002",
    labReportName: "lab_report_acacia_alwar.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    moisture: "16.8%",
    hmf: "9.5 mg/kg",
    c4Sugar: "Negative (Pass)",
    pollenCount: "21,000 grains/g",
    hash: "c3d7e8b9a0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7",
    previousHash: "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855",
    blockNumber: 148919,
    txRef: "0x12a3b4c5d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3",
    timestamp: "2026-08-23T09:45:00Z",
    quantityKg: 220
  }
];

export const INITIAL_BATCHES = [
  {
    batchId: "BT-LIC001-20260825-01",
    companyName: "ABC Honey Producers Pvt Ltd",
    licenseNumber: "LIC-SYN-00001",
    fssaiNumber: "FSSAI 10021051000124",
    productName: "Raw Organic Mustard & Multifloral Honey (500g Jar)",
    productNameHi: "कच्चा जैविक सरसों एवं बहुपुष्पी शहद (500 ग्राम जार)",
    batchQuantity: "500 kg (1,000 Jars)",
    processingInfo: "Cold-filtered at <40°C, zero additives, moisture standardized to 17.4%.",
    processingInfoHi: "कम तापमान (<40°C) पर छाना गया, कोई मिलावट नहीं, 17.4% नमी नियंत्रित।",
    createdDate: "2026-08-25",
    labName: "Demo Honey Testing Laboratory (NABL #104)",
    labReference: "LAB-SYN-00001",
    labReportName: "batch_master_report_01.pdf",
    labStatus: "Verified",
    blockchainStatus: "Verified",
    sourceHarvestIds: ["HB-BK0001-20260820-01", "HB-BK0001-20260824-02", "HB-BK0002-20260823-01"],
    blockNumber: 148920,
    hash: "fa2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p7q8r9s0t1u2v3w4x5y6z7a8b9c0d1e2f",
    previousHash: "c3d7e8b9a0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7",
    txRef: "0xbc51a4e67f89c0b1a2c3d4e5f6a7b8c9d0e1f2a3b4c5d6e7f8a9b0c1d2e3f4a5",
    timestamp: "2026-08-25T17:10:00Z"
  }
];

export const INITIAL_APIARIES = [
  {
    locationId: "LOC-001",
    name: "Apiary 1 - Rampur Mustard Belt (रामपुर सरसों क्षेत्र)",
    gps: "28.8041, 79.0250",
    villageName: "Village Loni / Rampur, UP",
    hiveCount: 14,
    flora: "Mustard & Wildflowers (सरसों एवं जंगली फूल)",
    status: "Healthy",
    lastInspection: "2026-08-25",
    notes: "Active foraging on local yellow mustard blooms."
  },
  {
    locationId: "LOC-002",
    name: "Apiary 2 - Moradabad Hills Farm (मुरादाबाद बाग)",
    gps: "28.8372, 78.7749",
    villageName: "Pakbara, Moradabad, UP",
    hiveCount: 10,
    flora: "Eucalyptus & Acacia (सफेदा व किकर)",
    status: "Needs Attention",
    lastInspection: "2026-08-23",
    notes: "Minor wasp activity observed near boxes 3 and 7."
  }
];

export const INITIAL_HEALTH_LOGS = [
  {
    id: "HL-001",
    locationId: "LOC-001",
    apiaryName: "Apiary 1 - Rampur Mustard Belt",
    date: "2026-08-20",
    status: "Healthy",
    statusHi: "स्वस्थ (सब ठीक है)",
    affectedColonies: 0,
    notes: "All colonies verified active and producing well. Queen present in all boxes. Good honey cap formation.",
    audioNote: true
  },
  {
    id: "HL-002",
    locationId: "LOC-002",
    apiaryName: "Apiary 2 - Moradabad Hills Farm",
    date: "2026-08-23",
    status: "Needs Attention",
    statusHi: "ध्यान दें (कीट/ततैया)",
    affectedColonies: 2,
    notes: "Minor wasp activity observed near colony boxes 2 and 5. Set up organic traps and reduced entrance reducer.",
    audioNote: true
  },
  {
    id: "HL-003",
    locationId: "LOC-001",
    apiaryName: "Apiary 1 - Rampur Mustard Belt",
    date: "2026-08-25",
    status: "Healthy",
    statusHi: "स्वस्थ (सब ठीक है)",
    affectedColonies: 0,
    notes: "Routine inspection complete. Honey frames look full, brood pattern uniform, no signs of varroa mites.",
    audioNote: false
  }
];

export const INITIAL_REMINDERS = [
  {
    id: "RM-001",
    title: "Check Organic Wasp Traps (ततैया ट्रैप की जाँच)",
    date: "2026-08-28",
    dueDays: 1,
    urgency: "high", // high (red), medium (amber), normal
    notes: "Inspect the sugar-vinegar wasp traps set up on Aug 23 at Apiary 2. Replenish bait if necessary.",
    status: "Pending"
  },
  {
    id: "RM-002",
    title: "Prepare Extraction Centrifuge & Clean Frames (शहद निकालाई उपकरण तैयार करें)",
    date: "2026-08-30",
    dueDays: 3,
    urgency: "medium",
    notes: "Sterilize stainless steel extractors, uncapping knives, and food-grade buckets for the upcoming mustard harvest.",
    status: "Pending"
  },
  {
    id: "RM-003",
    title: "Download Official NABL Lab Report (सरकारी लैब रिपोर्ट प्राप्त करें)",
    date: "2026-08-26",
    dueDays: 0,
    urgency: "normal",
    notes: "Download official report for harvest HB-BK0001-20260824-02 to share with ABC Honey FPO.",
    status: "Completed"
  }
];

export const INITIAL_HISTORY = [
  {
    id: "H-001",
    timestamp: "2026-08-20T10:15:30Z",
    type: "Harvest Created",
    details: "Created Harvest HB-BK0001-20260820-01 (Mustard/Multifloral) from Apiary 1 Rampur."
  },
  {
    id: "H-002",
    timestamp: "2026-08-20T11:00:00Z",
    type: "Health Log Added",
    details: "Added health status log for LOC-001: Healthy (All 14 colonies checked)."
  },
  {
    id: "H-003",
    timestamp: "2026-08-23T09:30:00Z",
    type: "Health Log Added",
    details: "Added health status log for LOC-002: Needs Attention (Wasp activity near boxes 2 & 5)."
  },
  {
    id: "H-004",
    timestamp: "2026-08-24T14:30:00Z",
    type: "Harvest Created",
    details: "Created Harvest HB-BK0001-20260824-02 (Eucalyptus) from Apiary 1 Rampur."
  },
  {
    id: "H-005",
    timestamp: "2026-08-25T12:00:00Z",
    type: "Location Updated",
    details: "Updated GPS location of LOC-001 to 28.8041, 79.0250 following apiary seasonal movement."
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
