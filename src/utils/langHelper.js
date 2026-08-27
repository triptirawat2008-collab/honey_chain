// Language dictionary and Text-to-Speech (TTS) helper for HoneyChain

export const TRANSLATIONS = {
  // Common Navigation & Demo
  demoBarTitle: {
    en: "SIH 2026 Demo Bar",
    hi: "स्मार्ट इंडिया हैकाथॉन डेमो बार"
  },
  switchToFarmer: {
    en: "🌾 Beekeeper View",
    hi: "🌾 किसान पोर्टल"
  },
  switchToCompany: {
    en: "🏢 Company / FPO",
    hi: "🏢 कंपनी / एफपीओ"
  },
  viewPublicQR: {
    en: "🔍 Verify Honey (QR)",
    hi: "🔍 शहद की जाँच (QR)"
  },
  onlineStatus: {
    en: "🟢 Live Sync (Online)",
    hi: "🟢 ऑनलाइन • लाइव सिंक"
  },
  offlineStatus: {
    en: "🟡 Saved Offline (2G/Patchy)",
    hi: "🟡 ऑफलाइन • फोन में सुरक्षित"
  },
  syncPendingMsg: {
    en: "Saved on phone. Will sync automatically when 2G/4G connects.",
    hi: "फोन में सुरक्षित है। इंटरनेट आने पर अपने आप सर्वर पर चला जाएगा।"
  },
  langToggleLabel: {
    en: "A / अ",
    hi: "अ / A"
  },
  listenAudio: {
    en: "Listen",
    hi: "सुनें"
  },

  // Landing Page
  brandTagline: {
    en: "Trace Every Drop. Protect Every Beekeeper.",
    hi: "खेत से बाज़ार तक - हर बूँद असली"
  },
  heroSubtitle: {
    en: "India's trusted honey traceability & simple hive management platform for beekeepers, FPOs, and conscious consumers.",
    hi: "भारतीय मधुमक्खी पालक किसानों, एफपीओ और उपभोक्ताओं के लिए भरोसेमंद शहद सत्यापन और सरल पेटी प्रबंधन मंच।"
  },
  getStartedBtn: {
    en: "Get Started / Farmer Login",
    hi: "शुरू करें / किसान लॉगिन"
  },
  scanBatchBtn: {
    en: "Scan / Verify Batch",
    hi: "शहद की शुद्धता जाँचें (QR स्कैन)"
  },
  trustPledge: {
    en: "हर बूँद असली — Every drop verified from hive to jar.",
    hi: "हर बूँद असली — पेटी से बोतल तक पूरी पारदर्शिता।"
  },

  // Benefit Cards
  benefit1Title: {
    en: "Simple Hive Tracking",
    hi: "सरल मधुमक्खी पालन"
  },
  benefit1Desc: {
    en: "Keep records of your hives and location changes easily with zero paperwork.",
    hi: "अपनी पेटियों और जगह बदलने का हिसाब आसानी से रखें, बिना किसी लिखा-पढ़ी के।"
  },
  benefit2Title: {
    en: "Lab & Quality Proof",
    hi: "लैब जाँच प्रमाण"
  },
  benefit2Desc: {
    en: "Store official test reports to get better prices from companies and FPOs.",
    hi: "शुद्धता की सरकारी लैब रिपोर्ट जोड़ें और कंपनियों से अपनी शहद का सही दाम पाएं।"
  },
  benefit3Title: {
    en: "Trusted Honey Certificate",
    hi: "डिजिटल QR कोड प्रमाण"
  },
  benefit3Desc: {
    en: "Generate tamper-evident QR codes so buyers and consumers trust your harvest.",
    hi: "हर डिब्बे के लिए सुरक्षित QR कोड बनाएं ताकि ग्राहक आपकी शहद पर पूरा भरोसा करें।"
  },

  // Role Selection
  selectRoleTitle: {
    en: "Select Your Account Type",
    hi: "अपना वर्ग चुनें"
  },
  selectRoleSubtitle: {
    en: "Choose how you want to use HoneyChain today",
    hi: "चुनें कि आप आज किस रूप में हनीचेन का उपयोग करना चाहते हैं"
  },
  farmerRoleTitle: {
    en: "Individual Beekeeper",
    hi: "स्वतंत्र किसान / मधुमक्खी पालक"
  },
  farmerRoleDesc: {
    en: "For local beekeepers managing 5 to 50+ hives. Record harvests and hive health easily.",
    hi: "5 से 50+ पेटियों वाले छोटे किसानों के लिए। शहद की निकालाई और पेटी की सेहत दर्ज करें।"
  },
  companyRoleTitle: {
    en: "Company / FPO / Processor",
    hi: "कंपनी / एफपीओ / शहद प्रोसेसर्स"
  },
  companyRoleDesc: {
    en: "For honey processing companies, cooperatives, and exporters creating batch jars.",
    hi: "शहद प्रसंस्करण कंपनियों और एफपीओ के लिए, जो किसानों से शहद खरीदकर बोतल में पैक करते हैं।"
  },
  continueAsFarmer: {
    en: "Continue as Beekeeper",
    hi: "किसान के रूप में आगे बढ़ें"
  },
  continueAsCompany: {
    en: "Continue as Company / FPO",
    hi: "कंपनी / एफपीओ के रूप में आगे बढ़ें"
  },

  // Beekeeper Dashboard
  apiaryLocations: {
    en: "My Apiary Sites",
    hi: "मेरे मधुमक्खी स्थान"
  },
  totalHives: {
    en: "Total Colony Boxes",
    hi: "कुल पेटियां"
  },
  harvestsCompleted: {
    en: "Harvests Completed",
    hi: "कुल शहद निकालाई"
  },
  hiveHealthStatus: {
    en: "Hive Health Status",
    hi: "पेटियों का स्वास्थ्य"
  },
  statusGood: {
    en: "Good / Healthy",
    hi: "स्वस्थ / सब ठीक है"
  },
  statusAttention: {
    en: "Needs Attention",
    hi: "ध्यान दें"
  },
  statusCritical: {
    en: "Critical Action Needed",
    hi: "तुरंत ध्यान दें (खतरा)"
  },
  createNewHarvestAction: {
    en: "➕ Create New Harvest",
    hi: "➕ नया शहद जोड़ें (निकालाई दर्ज करें)"
  },

  // Navigation Tabs
  tabOverview: {
    en: "Dashboard Overview",
    hi: "डैशबोर्ड"
  },
  tabHarvests: {
    en: "My Harvests",
    hi: "मेरी फसल / शहद"
  },
  tabCreateHarvest: {
    en: "New Harvest",
    hi: "नया शहद जोड़ें"
  },
  tabApiaries: {
    en: "Apiaries & Hives",
    hi: "स्थान और पेटियां"
  },
  tabHealth: {
    en: "Health Logs",
    hi: "स्वास्थ्य रिकॉर्ड"
  },
  tabReminders: {
    en: "Reminders & Alerts",
    hi: "याद दिलाएं / कार्य"
  },

  // Floral sources
  flowerMustard: {
    en: "Mustard",
    hi: "सरसों"
  },
  flowerEucalyptus: {
    en: "Eucalyptus",
    hi: "यूकेलिप्टस / सफेदा"
  },
  flowerAcacia: {
    en: "Acacia (Kikar)",
    hi: "किकर / बबूल"
  },
  flowerLitchi: {
    en: "Litchi",
    hi: "लीची"
  },
  flowerSunflower: {
    en: "Sunflower",
    hi: "सूरजमुखी"
  },
  flowerMultifloral: {
    en: "Multifloral / Wild Forest",
    hi: "बहुपुष्पी / जंगली फूल"
  },

  // Wizard Steps
  step1Title: {
    en: "Step 1: Beekeeper Confirmation",
    hi: "चरण 1: किसान पहचान पुष्टि"
  },
  step2Title: {
    en: "Step 2: Extraction Location",
    hi: "चरण 2: शहद निकालने का स्थान"
  },
  step3Title: {
    en: "Step 3: Harvest Date",
    hi: "चरण 3: शहद निकालने की तारीख"
  },
  step4Title: {
    en: "Step 4: Primary Floral Source",
    hi: "चरण 4: फूल का प्रकार (फ्लोरा)"
  },
  step5Title: {
    en: "Step 5: Lab Report & Photo",
    hi: "चरण 5: लैब रिपोर्ट / फोटो"
  },
  step6Title: {
    en: "Step 6: Smart Contract Verification",
    hi: "चरण 6: ब्लॉकचेन सत्यापन"
  },

  // Actions
  nextBtn: {
    en: "Next Step",
    hi: "आगे बढ़ें"
  },
  backBtn: {
    en: "Go Back",
    hi: "पीछे जाएं"
  },
  submitHarvestBtn: {
    en: "Verify & Generate QR Code",
    hi: "सत्यापित करें और QR कोड बनाएं"
  },
  printQrBtn: {
    en: "Print / Save QR Code for Containers",
    hi: "डिब्बों के लिए QR कोड डाउनलोड / प्रिंट करें"
  },
  doneDashboardBtn: {
    en: "Done, Back to Dashboard",
    hi: "हो गया, डैशबोर्ड पर जाएं"
  }
};

/**
 * Text-to-Speech playback helper
 * Speaks out in Hindi or English using Web Speech API
 */
export function speakText(text, lang = 'hi') {
  if (typeof window === 'undefined' || !('speechSynthesis' in window)) {
    console.warn('Speech synthesis not supported on this browser.');
    return;
  }

  try {
    // Cancel any ongoing speech
    window.speechSynthesis.cancel();

    const utterance = new SpeechSynthesisUtterance(text);
    utterance.rate = 0.9; // slightly slower for clarity
    utterance.pitch = 1.0;

    // Attempt to select Hindi or Indian English voice if available
    const voices = window.speechSynthesis.getVoices();
    if (lang === 'hi') {
      const hindiVoice = voices.find(v => v.lang.includes('hi') || v.name.includes('Hindi') || v.lang.includes('hi-IN'));
      if (hindiVoice) utterance.voice = hindiVoice;
      utterance.lang = 'hi-IN';
    } else {
      const indianEngVoice = voices.find(v => v.lang === 'en-IN' || v.name.includes('India'));
      if (indianEngVoice) utterance.voice = indianEngVoice;
      utterance.lang = 'en-IN';
    }

    window.speechSynthesis.speak(utterance);
  } catch (err) {
    console.warn('TTS playback error:', err);
  }
}
