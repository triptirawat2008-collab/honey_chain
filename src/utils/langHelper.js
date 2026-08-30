// Language dictionary and Text-to-Speech (TTS) helper for HoneyChain
// Focused on consumer accessibility, dual English/Hindi language, and plain everyday terminology

export const TRANSLATIONS = {
  // Common Navigation & Demo
  demoBarTitle: {
    en: "HoneyChain Demo Bar",
    hi: "हनीचेन डेमो बार"
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
  stopAudio: {
    en: "Stop",
    hi: "रोकें"
  },

  // Consumer Verification (Homepage & Modal)
  verifyHoneyTitle: {
    en: "Verify Your Store-Bought Honey",
    hi: "अपने शहद की शुद्धता व स्रोत जाँचें"
  },
  verifyHoneySubtitle: {
    en: "No login required. Instantly check test reports and beekeeper origin for any bottle of certified Indian honey.",
    hi: "लॉगिन की कोई आवश्यकता नहीं। किसी भी शहद की बोतल का लैब टेस्ट और किसान स्रोत तुरंत देखें।"
  },
  verifyTtsIntro: {
    en: "Verify your honey in two simple ways. You can scan the QR code on your honey jar label or type the batch number manually. No account or login is required.",
    hi: "शहद की जाँच दो आसान तरीकों से करें। आप अपनी शहद की शीशी पर दिया QR कोड स्कैन कर सकते हैं या बैच नंबर टाइप कर सकते हैं। किसी लॉगिन की आवश्यकता नहीं है।"
  },
  scanQrBtn: {
    en: "Scan QR Code",
    hi: "QR कोड स्कैन करें"
  },
  enterBatchLabel: {
    en: "Enter Batch Number",
    hi: "बैच नंबर दर्ज करें"
  },
  enterBatchPlaceholder: {
    en: "e.g. BT-LIC001-20260825-01",
    hi: "जैसे: BT-LIC001-20260825-01"
  },
  verifyBatchActionBtn: {
    en: "Verify Honey",
    hi: "शहद की जाँच करें"
  },
  qrModalTitle: {
    en: "Scan Honey Jar QR Code",
    hi: "शहद जार QR कोड स्कैन करें"
  },
  qrModalSubtitle: {
    en: "Point your phone camera at the QR code on your honey bottle or upload an image.",
    hi: "अपनी शहद की बोतल पर छपे QR कोड को कैमरे से देखें या फोटो अपलोड करें।"
  },
  uploadQrImageBtn: {
    en: "Upload QR Code Image",
    hi: "QR कोड फोटो अपलोड करें"
  },
  closeBtn: {
    en: "Close",
    hi: "बंद करें"
  },
  scanningText: {
    en: "Checking Honey Record...",
    hi: "शहद का रिकॉर्ड जाँचा जा रहा है..."
  },
  scanningSubtext: {
    en: "Connecting to registry to retrieve lab test results and farmer origin...",
    hi: "रजिस्ट्री से लैब रिपोर्ट और किसान की जानकारी जाँची जा रही है..."
  },

  // Error Messages (Everyday Human-Friendly Phrasing)
  errorMissingBatch: {
    en: "Please enter a batch number.",
    hi: "कृपया एक बैच नंबर दर्ज करें।"
  },
  errorNotFoundTitle: {
    en: "Batch Number Not Found",
    hi: "बैच नंबर नहीं मिला"
  },
  errorNotFoundDesc: {
    en: "We couldn't find this batch number. Please check the label on your honey jar and try again.",
    hi: "हमें यह बैच नंबर नहीं मिला। कृपया अपने शहद के डिब्बे पर छपा नंबर देखकर दोबारा प्रयास करें।"
  },
  errorNotFoundTts: {
    en: "We could not find this batch number. Please check the label on your honey jar and try again.",
    hi: "हमें यह बैच नंबर नहीं मिला। कृपया अपने शहद के डिब्बे पर लिखा नंबर जाँचकर पुनः प्रयास करें।"
  },
  errorQrReadFail: {
    en: "We couldn't read that QR code. Please try again or enter the batch number manually.",
    hi: "हम वह QR कोड नहीं पढ़ सके। कृपया दोबारा प्रयास करें या बैच नंबर हाथ से दर्ज करें।"
  },
  errorNetworkFail: {
    en: "We couldn't check the honey right now. Please try again in a moment.",
    hi: "हम अभी शहद की जाँच नहीं कर सके। कृपया कुछ देर बाद पुनः प्रयास करें।"
  },
  tryAgainBtn: {
    en: "Try Again",
    hi: "पुनः प्रयास करें"
  },
  backToHomeBtn: {
    en: "Back to Home",
    hi: "मुख्य पृष्ठ पर वापस"
  },

  // Consumer Verification Results Page
  verificationSuccessful: {
    en: "Verification Successful",
    hi: "सत्यापन सफल"
  },
  statusVerifiedTag: {
    en: "Verified",
    hi: "सत्यापित"
  },
  statusVerifiedSub: {
    en: "Official lab test and beekeeper provenance confirmed.",
    hi: "सरकारी लैब जाँच और किसान स्रोत प्रमाणित।"
  },
  statusTamperedTitle: {
    en: "⚠️ Record Mismatch Detected",
    hi: "⚠️ डेटा में अंतर — रिकॉर्ड मेल नहीं खाता"
  },
  statusTamperedSub: {
    en: "The record values for this bottle do not match the official lab register. Please inspect the jar seal.",
    hi: "इस बोतल का डेटा सरकारी लैब रिकॉर्ड से मेल नहीं खा रहा है। मिलावट का संदेह हो सकता है।"
  },
  verifiedTts: {
    en: "Verification successful. This honey is verified with authentic beekeeper origin and passed all official lab quality tests.",
    hi: "सत्यापन सफल रहा। यह शहद वास्तविक किसान के खेत से निकली है और सभी सरकारी लैब मानकों पर खरी उतरी है।"
  },
  tamperedTts: {
    en: "Warning. Record mismatch detected. The details on this bottle do not match the official registry.",
    hi: "चेतावनी। डेटा में अंतर पाया गया। इस बोतल का विवरण आधिकारिक रिकॉर्ड से मेल नहीं खाता है।"
  },
  productDetailsSection: {
    en: "Product & Packaging Details",
    hi: "उत्पाद एवं पैकेजिंग विवरण"
  },
  processingBrandLabel: {
    en: "Brand / Packager:",
    hi: "ब्रांड / पैकेजिंग संस्था:"
  },
  fssaiLicenseLabel: {
    en: "FSSAI License:",
    hi: "FSSAI लाइसेंस नंबर:"
  },
  packDateLabel: {
    en: "Packaging Date:",
    hi: "पैकिंग तारीख:"
  },
  batchQuantityLabel: {
    en: "Batch Volume:",
    hi: "बैच की कुल मात्रा:"
  },
  originTrailTitle: {
    en: "Journey from Hive to Jar",
    hi: "छत्ते से जार तक का सफ़र"
  },
  originTrailTts: {
    en: "Journey from hive to jar. See how this honey was harvested by local beekeepers, tested in the lab, and bottled.",
    hi: "छत्ते से जार तक का सफ़र। देखें कि यह शहद किसानों के छत्ते से कैसे निकाली गई, लैब में कैसे जाँची गई और कैसे पैक हुई।"
  },
  sourceBeekeepersTitle: {
    en: "Source Beekeepers",
    hi: "हमारे स्रोत किसान"
  },
  sourceBeekeepersTts: {
    en: "Source beekeepers. Meet the registered beekeepers who produced this honey.",
    hi: "स्रोत किसान। जानिए उन पंजीकृत किसानों के बारे में जिन्होंने इस शहद का उत्पादन किया।"
  },
  labScorecardTitle: {
    en: "Laboratory Quality Scorecard",
    hi: "सरकारी लैब गुणवत्ता स्कोरकार्ड"
  },
  labScorecardTts: {
    en: "Laboratory quality scorecard. Moisture, sugar screen, and freshness have all been tested according to national standards.",
    hi: "लैब गुणवत्ता स्कोरकार्ड। नमी, शर्करा जाँच और ताजगी सरकारी मानकों के अनुरूप जाँची गई है।"
  },
  viewLabCertBtn: {
    en: "View Lab Certificate",
    hi: "लैब प्रमाणपत्र देखें"
  },
  techDetailsDrawerTitle: {
    en: "Technical & Security Details",
    hi: "तकनीकी एवं सुरक्षा विवरण"
  },
  techDetailsDrawerHint: {
    en: "Optional technical ledger data for inspectors and auditors.",
    hi: "निरीक्षकों और तकनीकी जाँच के लिए अपरिवर्तनीय लेजर रिकॉर्ड।"
  },

  // Landing Page Hero
  brandTagline: {
    en: "Trace Every Drop. Protect Every Beekeeper.",
    hi: "खेत से बाज़ार तक - हर बूँद असली"
  },
  heroSubtitle: {
    en: "India's trusted honey traceability platform for conscious consumers, rural beekeepers, and FPOs.",
    hi: "भारतीय मधुमक्खी पालक किसानों, एफपीओ और उपभोक्ताओं के लिए भरोसेमंद शहद सत्यापन मंच।"
  },
  getStartedBtn: {
    en: "Beekeeper & Company Login",
    hi: "किसान एवं कंपनी लॉगिन"
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
    en: "Official NABL test reports ensure quality standards and protect against adulteration.",
    hi: "सरकारी NABL लैब रिपोर्ट से शहद की गुणवत्ता सुनिश्चित होती है और सही दाम मिलता है।"
  },
  benefit3Title: {
    en: "Trusted QR Certificate",
    hi: "डिजिटल QR कोड प्रमाण"
  },
  benefit3Desc: {
    en: "Every jar gets a unique verification code so consumers can check origin in 5 seconds.",
    hi: "हर बोतल पर सुरक्षित QR कोड होता है जिससे खरीदार 5 सेकंड में स्रोत देख सकते हैं।"
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
  }
};

/**
 * Stop any ongoing speech synthesis
 */
export function stopSpeaking() {
  if (typeof window !== 'undefined' && 'speechSynthesis' in window) {
    try {
      window.speechSynthesis.cancel();
      window.speechSynthesis.onvoiceschanged = null;
    } catch (e) {
      console.warn('Error cancelling speech:', e);
    }
  }
}

function getVoiceForLang(lang, voices = []) {
  if (!voices.length) return null;

  const normalizedLang = String(lang || '').toLowerCase();

  if (normalizedLang === 'hi' || normalizedLang === 'hi-in' || normalizedLang.startsWith('hi')) {
    return voices.find(v => {
      const voiceLang = (v.lang || '').toLowerCase();
      return voiceLang === 'hi-in' || voiceLang.startsWith('hi');
    }) || null;
  }

  return voices.find(v => {
    const voiceLang = (v.lang || '').toLowerCase();
    return voiceLang === 'en-in' || voiceLang.startsWith('en');
  }) || null;
}

/**
 * Text-to-Speech playback helper
 * Speaks out in Hindi or English using Web Speech API
 */
export function speakText(text, lang = 'hi', onStart = null, onEnd = null) {
  if (typeof window === 'undefined' || !('speechSynthesis' in window)) {
    if (onEnd) onEnd();
    return;
  }

  try {
    const sanitizedText = (text || '').trim();
    if (!sanitizedText) {
      if (onEnd) onEnd();
      return;
    }

    const speak = () => {
      window.speechSynthesis.cancel();

      const utterance = new SpeechSynthesisUtterance(sanitizedText);
      utterance.rate = 0.92;
      utterance.pitch = 1.0;
      const normalizedLang = String(lang || '').toLowerCase();
      utterance.lang = normalizedLang === 'hi' || normalizedLang === 'hi-in' || normalizedLang.startsWith('hi') ? 'hi-IN' : 'en-IN';

      const voices = window.speechSynthesis.getVoices();
      const selectedVoice = getVoiceForLang(lang, voices);

      if (selectedVoice && (normalizedLang === 'hi' || normalizedLang === 'hi-in' || normalizedLang.startsWith('hi'))) {
        utterance.voice = selectedVoice;
      } else if (selectedVoice) {
        utterance.voice = selectedVoice;
      }

      utterance.onstart = () => {
        if (onStart) onStart();
      };

      utterance.onend = () => {
        if (onEnd) onEnd();
      };

      utterance.onerror = () => {
        if (onEnd) onEnd();
      };

      window.speechSynthesis.speak(utterance);
    };

    const initialVoices = window.speechSynthesis.getVoices();
    if (initialVoices.length > 0) {
      speak();
      return;
    }

    const handleVoicesReady = () => {
      const voices = window.speechSynthesis.getVoices();
      if (voices.length > 0) {
        window.speechSynthesis.onvoiceschanged = null;
        speak();
      }
    };

    window.speechSynthesis.onvoiceschanged = handleVoicesReady;
  } catch (err) {
    if (onEnd) onEnd();
  }
}
