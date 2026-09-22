#!/usr/bin/env bash
url="$1"
shift
type="${1:single}"
shift
cropThumbnailToSquare="${1:false}"


date_format='%(release_year,release_date>%Y,upload_date>%Y)s'
title_format='%(track,title,fulltitle,alt_title,id)s'
artist_format=''
album_format=''
track_format='%(track_number,playlist_index)s'
dir_name_format=''

if [[ "$type" = 'album' ]]; then
    album_format='%(album,playlist_title,playlist,id)s'
    dir_name_format="$album_format"
    date_format='%(release_year,release_date>%Y,upload_date>%Y)s'
    artist_format='%(artist,artists,playlist_channel,playlist_uploader,channel,uploader,playlist_channel_id,playlist_uploader_id,channel_id,uploader_id)s'
elif [[ "$type" = 'single' ]]; then
    dir_name_format="$title_format"
    album_format="$title_format"
    artist_format='%(artist,artists,channel,uploader,channel_id,uploader_id)s'
else
    echo 'No type provided, exitting:'
    echo 'Usage: $0 type: album/single (cropThumbnailToSquare: bool)'
    exit 1
fi

dir_prefix="$dir_name_format [downloaded]/"


cmd_arr=( 
    yt-dlp "$url" 
    -o "${dir_prefix}${title_format} - %(title)U.%(ext)s" 
    -o "thumbnail:${dir_prefix}folder.%(ext)s" 
    --audio-format flac/mp3
    --extract-audio 
    --convert-thumbnails png 
    -o "thumbnail:${dir_prefix}/folder.%(ext)s" 
    --write-thumbnail
    --embed-thumbnail

    --embed-metadata
    --parse-metadata "${date_format}:%(meta_date)s" 
    --parse-metadata "${title_format}:%(meta_title)s"
    --parse-metadata "${track_format}:%(meta_track)s"
    --parse-metadata ":(?P<meta_genre>)"
    --parse-metadata ":(?P<meta_synopsis>)"
    --parse-metadata ":(?P<meta_description>)"
    --concurrent-fragments 4 
)

if [[ "$type" = "album" ]]; then
    cmd_arr+=( "--yes-playlist" )
    cmd_arr+=( "--playlist-items" "1:50:1" )
else
    cmd_arr+=( "--no-playlist" )
fi

if [[ cropThumbnailToSquare = "true" ]]; then
    cmd_arr+=( "--postprocessor-args" "ThumbnailsConvertor+ffmpeg_o:-c:v png -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" )
fi

printf "%s " "${cmd_arr[@]}"
echo
"${cmd_arr[@]}"
