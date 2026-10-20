#!/bin/zsh
# v2: realistic knife chop, cloudy pla-ra, calm hero end card with steam.
set -e
cd "${0:A:h}"
C=../clips
mkdir -p seg2lo
# clip  start  duration
SHOTS=(
  "shot1_a 0.0 2.2"
  "shot2_c 0.4 1.6"
  "v2knife_b 1.8 2.0"
  "shot4_b 0.0 1.5"
  "v2expl_b 0.0 1.5"
  "v2pour_b 0.0 2.0"
  "shot7_b 0.0 1.3"
)
list=seg2lo/list.txt; : > $list
i=0
for s in $SHOTS; do
  set -- ${=s}
  i=$((i+1)); out=seg2lo/$(printf %02d $i).mp4
  ffmpeg -v error -y -ss $2 -i $C/$1.mp4 -t $3 \
    -vf "scale=720:1280,fps=24,format=yuv420p" -af "aresample=48000,aformat=channel_layouts=stereo" \
    -c:v libx264 -crf 17 -preset medium -c:a aac -b:a 192k $out
  echo "file '$(basename $out)'" >> $list
done
# End card: calm hero with rising steam, title fades in.
ffmpeg -v error -y -i $C/v2hero_a.mp4 -loop 1 -t 3.2 -i endcard_lo.png -t 3.2 \
  -filter_complex "[0:v]scale=720:1280,fps=24[bg];[1]format=rgba,fade=in:st=0.5:d=0.6:alpha=1[t];[bg][t]overlay=0:0,format=yuv420p[v];[0:a]aresample=48000,aformat=channel_layouts=stereo,afade=out:st=2.4:d=0.8[a]" \
  -map "[v]" -map "[a]" -t 3.2 -c:v libx264 -crf 17 -preset medium -c:a aac -b:a 192k seg2lo/08.mp4
echo "file '08.mp4'" >> $list
ffmpeg -v error -y -f concat -safe 0 -i $list -c:v libx264 -crf 18 -preset slow -af "loudnorm=I=-14:TP=-1.5:LRA=11,aresample=48000" -c:a aac -b:a 192k -movflags +faststart ../plara_sophanua_ad_v2_lo.mp4
ffprobe -v error -show_entries format=duration -of csv=p=0 ../plara_sophanua_ad_v2_lo.mp4
