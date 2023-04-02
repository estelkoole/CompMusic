library(tidyverse)
library(spotifyr)
library(compmus)

time_has_come <- '4quZBn5FeJhJoucjer82IO?si=8c325ecee26d4423'
gymnopedie <- '5NGtFXVpXSvwunEIGeviY3?si=c2706dce2fe64d4b'
tears <- '7GbAp0HKPQW7WnFJAzMoRk?si=d6bfc60f4bd74a0f'
abandon <- '5YZ1S9UfTHUxuIF3eTIGGf?si=008da223aaf44b88'
exit <- '4Na0siMtWOW9pJoWJ1Ponv?si=d5166cf62f6a4952'

graveola <- get_tidy_audio_analysis(exit)

tempogram <- graveola |>
  tempogram(window_size = 8, hop_size = 1, cyclic = FALSE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

tempogram_cyclic <- graveola |>
  tempogram(window_size = 8, hop_size = 1, cyclic = TRUE) |>
  ggplot(aes(x = time, y = bpm, fill = power)) +
  geom_raster() +
  scale_fill_viridis_c(guide = "none") +
  labs(x = "Time (s)", y = "Tempo (BPM)") +
  theme_classic()

saveRDS(object = tempogram_cyclic,file = "data/exit-tempo.RDS")
