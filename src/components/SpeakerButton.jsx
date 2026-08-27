import React, { useState } from 'react';
import { Volume2, VolumeX } from 'lucide-react';
import { speakText } from '../utils/langHelper';

export default function SpeakerButton({ text, lang = 'hi', size = 18, style = {}, title = "Listen / सुनें" }) {
  const [isSpeaking, setIsSpeaking] = useState(false);

  const handleClick = (e) => {
    e.stopPropagation();
    if (!text) return;

    setIsSpeaking(true);
    speakText(text, lang);

    // Auto reset speaking animation state after a short period
    const words = text.split(/\s+/).length;
    const estDurationMs = Math.max(1800, words * 380);
    setTimeout(() => {
      setIsSpeaking(false);
    }, estDurationMs);
  };

  return (
    <button
      type="button"
      className={`speaker-btn ${isSpeaking ? 'speaking-active' : ''}`}
      onClick={handleClick}
      title={title}
      style={{
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: isSpeaking ? 'var(--color-primary)' : 'rgba(230, 154, 16, 0.15)',
        color: isSpeaking ? '#FFFFFF' : 'var(--color-primary-dark)',
        border: '1px solid rgba(230, 154, 16, 0.35)',
        borderRadius: '50%',
        width: `${size + 14}px`,
        height: `${size + 14}px`,
        cursor: 'pointer',
        transition: 'all 0.2s ease',
        flexShrink: 0,
        padding: 0,
        ...style
      }}
      aria-label={title}
    >
      <Volume2 size={size} className={isSpeaking ? 'pulse-icon' : ''} />
    </button>
  );
}
