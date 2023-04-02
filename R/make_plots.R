urgh = readRDS(file = "data/urgh-data.RDS")
nostalgia = readRDS(file = "data/nostalgia-data.RDS")
spelen = readRDS(file = "data/spelen-data.RDS")
all_songs = readRDS(file = "data/all_songs-data.RDS")

sad_lists <- rbind(urgh, nostalgia, spelen)

violin_plot <- ggplot(sad_lists, aes(x = playlist_name, y = valence)) + geom_violin()
loudness_plot <- ggplot(sad_lists, aes(text = track.name, x = tempo, y = loudness, size = valence, color='pink')) + geom_point() + facet_wrap(~playlist_name)

saveRDS(object = violin_plot,file = "data/violin_plot.RDS")
saveRDS(object = loudness_plot,file = "data/loudness_plot.RDS")

box_tempo <- sad_lists |>
  ggplot(aes(x = playlist_name, y = tempo)) +
  geom_boxplot()

saveRDS(object = box_tempo,file = "data/tempo_plot.RDS")

key_plot <- sad_lists |>
  ggplot(aes(x = mode, fill = 'red')) +
  geom_bar() +
  facet_wrap(~playlist_name)

saveRDS(object = key_plot,file = "data/key_plot.RDS")
