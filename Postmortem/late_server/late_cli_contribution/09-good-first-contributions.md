# 09. Good First Contributions

Safer early contribution targets:

- CLI docs/help text improvements
- config parsing polish
- focused logging/error-message improvements
- small websocket-client cleanup
- isolated audio helper cleanup

Higher-risk areas:

- token handshake logic
- stdin/raw-mode lifecycle
- output callback/audio pipeline changes
- cross-platform transport behavior

Start with focused changes before touching SSH mode orchestration or the audio callback path.
