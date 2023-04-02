library(tidyverse)
library(spotifyr)
library(compmus)

aura <- '3txAMdbJitTk5qSlkEV7vr?si=9c6ba1a6d11f410d'
time <- '4quZBn5FeJhJoucjer82IO?si=8c325ecee26d4423'
die <- '7iPlcFvOMOzt6v0QvcAueZ?si=d20f823433224b31'

bzt <-
  get_tidy_audio_analysis(die) |> # Change URI.
  compmus_align(bars, segments) |>                     # Change `bars`
  select(bars) |>                                      #   in all three
  unnest(bars) |>                                      #   of these lines.
  mutate(
    pitches =
      map(segments,
          compmus_summarise, pitches,
          method = "rms", norm = "euclidean"              # Change summary & norm.
      )
  ) |>
  mutate(
    timbre =
      map(segments,
          compmus_summarise, timbre,
          method = "rms", norm = "euclidean"              # Change summary & norm.
      )
  )

timbre <- bzt |>
  compmus_gather_timbre() |>
  ggplot(
    aes(
      x = start + duration / 2,
      width = duration,
      y = basis,
      fill = value
    )
  ) +
  geom_tile() +
  labs(x = "Time (s)", y = NULL, fill = "Magnitude") +
  scale_fill_viridis_c() +                              
  theme_classic()

saveRDS(object = timbre,file = "data/die-timbre.RDS")

timbre

