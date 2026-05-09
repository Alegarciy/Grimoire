# 05. Audio Runtime And Visualizer

The CLI does not just play audio; it also analyzes the played output.

Main responsibilities:

- consume the MP3 stream
- decode audio
- resample if needed
- play through CPAL
- track muted/volume-adjusted audible samples
- generate visualizer frames from audible output

Critical invariant:

The analyzer should reflect what the user actually hears, not just raw decoded samples.
