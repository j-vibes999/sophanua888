#!/bin/zsh
# Cut the Veo takes into a ~16s vertical ad (720x1280, 24fps) like the reference.
set -e
cd "${0:A:h}"
C=../clips
mkdir -p seg
# clip  start  duration  speed(1=normal, 2=half-speed)  pre-filter
# shot 3 is cropped from the right edge: Veo drew fingers on the knife handle.
SHOTS=(
  "shot1_a 0.0 2.2 1 null"
  "shot2_c 0.4 1.6 1 null"
  "shot3_a 0.0 1.5 1 crop=612:1088:0:96"
  "shot4_b 0.0 1.6 1 null"
  "shot5_a 0.0 1.6 1 null"
  "shot6_a 0.0 2.0 1 null"
  "shot7_b 0.0 1.4 1 null"
  "shot8_a 0.0 0.5 2 null"
)
list=seg/list.txt; : > $list
i=0
for s in $SHOTS; do
  set -- ${=s}
  i=$((i+1)); out=seg/$(printf %02d $i).mp4
  if [[ $4 == 1 ]]; then slow="null"; aslow="anull"; else slow="setpts=$4*PTS,minterpolate=fps=24:mi_mode=blend"; aslow="atempo=1/$4"; fi
  ffmpeg -v error -y -ss $2 -i $C/$1.mp4 -t $3 \
    -vf "$5,scale=720:1280,$slow,fps=24,format=yuv420p" -af "$aslow,aresample=48000,aformat=channel_layouts=stereo" \
    -c:v libx264 -crf 17 -preset medium -c:a aac -b:a 192k $out
  echo "file '$(basename $out)'" >> $list
done

# End card: freeze shot 8 at 0.5s (the crown splash before it turns into a solid wall),
# slow push-in, title fades in; the splash audio keeps playing underneath.
ffmpeg -v error -y -ss 0.48 -i $C/shot8_a.mp4 -frames:v 1 seg/hero.png
ffmpeg -v error -y -loop 1 -t 2.6 -i seg/hero.png -loop 1 -t 2.6 -i endcard.png -ss 0.5 -t 2.6 -i $C/shot8_a.mp4 \
  -filter_complex "[0]scale=1440:2560,zoompan=z='1+0.0009*on':x='iw/2-(iw/zoom/2)':y='ih/2-(ih/zoom/2)':d=1:s=720x1280:fps=24[bg];[1]format=rgba,fade=in:st=0.25:d=0.5:alpha=1[t];[bg][t]overlay=0:0,format=yuv420p[v];[2:a]aresample=48000,aformat=channel_layouts=stereo,afade=out:st=1.8:d=0.8[a]" \
  -map "[v]" -map "[a]" -t 2.6 -c:v libx264 -crf 17 -preset medium -c:a aac -b:a 192k seg/09.mp4
echo "file '09.mp4'" >> $list

ffmpeg -v error -y -f concat -safe 0 -i $list -c:v libx264 -crf 18 -preset slow -c:a aac -b:a 192k -movflags +faststart ../plara_sophanua_ad_v1.mp4
ffprobe -v error -show_entries format=duration -of csv=p=0 ../plara_sophanua_ad_v1.mp4
