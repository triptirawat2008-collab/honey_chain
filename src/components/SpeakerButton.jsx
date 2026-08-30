import React, { useState, useEffect } from 'react';
import { Volume2, Square } from 'lucide-react';
import { speakText, stopSpeaking } from '../utils/langHelper';

export default function SpeakerButton({ 
  text, 
  lang = 'hi', 
  size = 18, 
  showLabel = false,
  style = {}, 
  title = null
}) {
  const [isSpeaking, setIsSpeaking] = useState(false);

  const defaultTitle = isSpeaking 
    ? (lang === 'hi' ? 'रोकें (Stop)' : 'Stop Audio')
    : (lang === 'hi' ? 'सुनें (Listen)' : 'Listen Audio');

  const activeTitle = title || defaultTitle;
  const labelText = isSpeaking 
    ? (lang === 'hi' ? 'रोकें' : 'Stop')
    : (lang === 'hi' ? 'सुनें' : 'Listen');

  // Cancel speech on unmount
  useEffect(() => {
    return () => {
      stopSpeaking();
    };
  }, []);

  const handleClick = (e) => {
    e.stopPropagation();
    if (!text) return;

    if (isSpeaking) {
      stopSpeaking();
      setIsSpeaking(false);
      return;
    }

    setIsSpeaking(true);
    speakText(
      text, 
      lang,
      () => setIsSpeaking(true),
      () => setIsSpeaking(false)
    );
  };

  if (showLabel) {
    return (
      <button
        type="button"
        className={`btn-speaker-labeled ${isSpeaking ? 'speaking-active' : ''}`}
        onClick={handleClick}
        title={activeTitle}
        aria-label={activeTitle}
        style={{
          display: 'inline-flex',
          alignItems: 'center',
          gap: '0.4rem',
          padding: '0.35rem 0.75rem',
          fontSize: '0.85rem',
          fontWeight: 700,
          borderRadius: '20px',
          background: isSpeaking ? '#B45309' : 'rgba(230, 154, 16, 0.15)',
          color: isSpeaking ? '#FFFFFF' : '#92400E',
          border: isSpeaking ? '1px solid #B45309' : '1px solid rgba(217, 119, 6, 0.35)',
          cursor: 'pointer',
          transition: 'all 0.2s ease',
          lineHeight: 1.2,
          ...style
        }}
      >
        {isSpeaking ? (
          <>
            <Square size={size - 2} fill="currentColor" />
            <span>{labelText}</span>
          </>
        ) : (
          <>
            <Volume2 size={size} />
            <span>{labelText}</span>
          </>
        )}
      </button>
    );
  }

  return (
    <button
      type="button"
      className={`speaker-btn ${isSpeaking ? 'speaking-active' : ''}`}
      onClick={handleClick}
      title={activeTitle}
      aria-label={activeTitle}
      style={{
        display: 'inline-flex',
        alignItems: 'center',
        justifyContent: 'center',
        background: isSpeaking ? '#B45309' : 'rgba(230, 154, 16, 0.15)',
        color: isSpeaking ? '#FFFFFF' : '#92400E',
        border: isSpeaking ? '1px solid #B45309' : '1px solid rgba(217, 119, 6, 0.35)',
        borderRadius: '50%',
        width: `${size + 14}px`,
        height: `${size + 14}px`,
        cursor: 'pointer',
        transition: 'all 0.2s ease',
        flexShrink: 0,
        padding: 0,
        ...style
      }}
    >
      {isSpeaking ? (
        <Square size={size - 4} fill="currentColor" />
      ) : (
        <Volume2 size={size} />
      )}
    </button>
  );
}
