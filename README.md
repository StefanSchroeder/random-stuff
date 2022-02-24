# random-stuff

Random notes.

## Tool to cleanup filenames

detox

## Convert video to audio for audio CD.

ffmpeg -i input.mp4 -vn -acodec pcm_s16le -ar 44100 -ac 2 output.wav

## Download audio with youtube-dl

youtube-dl -f 'bestaudio[ext=m4a]' 'http://youtu.be/VIDEOHASH'
