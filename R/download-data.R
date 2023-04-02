urgh <- get_playlist_audio_features('', '3zHgInxVVBHhge5rc71TBk?si=fbb92d3bd6134cbb')
nostalgia <- get_playlist_audio_features('', '6WjvDxvrtZHQO0I4sjhWcG?si=bf12bda2f6444809')
spelen <- get_playlist_audio_features('', '75aP68kX1ZjvXTLFmwAn1N?si=f94ac20a680343ac')

all_songs <- get_playlist_audio_features('', '12K480rqESLeIc9bbGfoUA?si=77b1c31fd8cd4794')

saveRDS(object = urgh,file = "data/urgh-data.RDS")
saveRDS(object = nostalgia,file = "data/nostalgia-data.RDS")
saveRDS(object = spelen,file = "data/spelen-data.RDS")

saveRDS(object = all_songs,file = "data/all_songs-data.RDS")
