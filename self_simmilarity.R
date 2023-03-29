library(readr)
library(lubridate)
library(ggplot2)
library(tidyverse)
library(spotifyr)
library(compmus)

urgh <- get_playlist_audio_features('', '3zHgInxVVBHhge5rc71TBk?si=fbb92d3bd6134cbb')
nostalgia <- get_playlist_audio_features('', '6WjvDxvrtZHQO0I4sjhWcG?si=bf12bda2f6444809')
spelen <- get_playlist_audio_features('', '75aP68kX1ZjvXTLFmwAn1N?si=f94ac20a680343ac')

sad_lists <- rbind(urgh, nostalgia, spelen)

sad_lists %>%
  group_by(playlist_name) %>%
  summarize(median(valence), median(loudness))

# filter out median valence songs 
sad_lists %>%
  filter(track.name %in% c('Bunker','Abandon Window', 'Solace'))

# filter out median loudness songs
sad_lists %>%
  filter(track.name %in% c('That Funny Feeling', 'Balcony Hotel - From \'Miss\', 'Karma Police'))


bzt <-
  get_tidy_audio_analysis("2igwFfvr1OAGX9SKDCPBwO?si=9e18d85273424ab5") |> # Change URI.
  compmus_align(sections, segments) |>                     # Change `bars`
  select(sections) |>                                      #   in all three
  unnest(sections) |>                                      #   of these lines.
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
  compmus_self_similarity(timbre, "cosine") |> 
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
