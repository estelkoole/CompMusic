library(tidyverse)
library(spotifyr)
library(compmus)

serenade <- '3XiFWZoHQtGUYIdtShPwPD?si=25571d28e47e462d'
imagine <- '7pKfPomDEeI4TPT6EOYjn9?si=4ffd2dc89ffc4e10'

bey <-
  get_tidy_audio_analysis(imagine) |>
  select(segments) |>
  unnest(segments) |>
  select(start, duration, pitches)

chromogram <- bey |>
  mutate(pitches = map(pitches, compmus_normalise, "euclidean")) |>
  compmus_gather_chroma() |> 
  ggplot(
    aes(
      x = start + duration / 2,
      width = duration,
      y = pitch_class,
      fill = value
    )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  theme_minimal() +
  scale_fill_viridis_c()

chromogram

saveRDS(object = chromogram,file = "data/imagine-chroma.RDS")

