library(readr)
library(lubridate)
library(ggplot2)
library(tidyverse)
library(spotifyr)
library(compmus)

gymnopedie <- '0Dkibk70FDp6t7eOZNemNQ?si=21784cd5afb64fa0'
arctic <- '0BxE4FqsDD1Ot4YuBXwAPp?si=917b61f5c1e143aa'

bzt <-
  get_tidy_audio_analysis(gymnopedie) |> # Change URI.
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

bzt |>
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

self_sim <- bzt |>
  compmus_self_similarity(pitches, "cosine") |> 
  ggplot(
    aes(
      x = xstart + xduration / 2,
      width = xduration,
      y = ystart + yduration / 2,
      height = yduration,
      fill = d
    )
  ) +
  geom_tile() +
  coord_fixed() +
  scale_fill_viridis_c(guide = "none") +
  theme_classic() +
  labs(x = "", y = "")

self_sim

saveRDS(object = self_sim,file = "data/gymnopedie-self.RDS")

