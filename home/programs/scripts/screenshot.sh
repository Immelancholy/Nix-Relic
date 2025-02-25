#!/usr/bin/env bash
USAGE() {
	cat <<"USAGE"

	Usage: $(basename "$0") [option]
	Options:
		p     Print all outputs
		s     Select area or window to screenshot
		sf    Select area or window with frozen screen
		m     Screenshot focused monitor

USAGE
}

SCREENSHOT_POST_COMMAND+=(
)

SCREENSHOT_PRE_COMMAND+=(
)

pre_cmd() {
	for cmd in "${SCREENSHOT_PRE_COMMAND[@]}"; do
		eval "$cmd"
	done
	trap 'post_cmd' EXIT
}

post_cmd() {
	for cmd in "${SCREENSHOT_POST_COMMAND[@]}"; do
		eval "$cmd"
	done
}

if [ -z "$XDG_SCREENSHOTS_DIR" ]; then
	XDG_SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
fi

confDir="${confDir:-$XDG_CONFIG_HOME}"
save_dir="${XDG_SCREENSHOTS_DIR}"
mkdir -p "$save_dir"
save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
temp_screenshot="/tmp/screenshot.png"
annotation_tool=${GRIMBLAST_EDITOR}
annotation_args=("-o" "${save_dir}/${save_file}" "-f" "${temp_screenshot}")


swpy_dir="${configDir}/swappy"
mkdir -p "$swpy_dir"
echo -e "[Default]\nsave_dir=$save_dir\nsave_filename_format=$save_file" >"${swpy_dir}"/config

annotation_args+=("${SCREENSHOT_ANNOTATION_ARGS[@]}")
evaluated_annotation_args=$(eval echo "${annotation_args[@]}")

pre_cmd

case $1 in
p) # print all outputs
	# timeout 0.2 slurp # capture animation lol
	# shellcheck disable=SC2086
	grimblast copysave screen $temp_screenshot && "${annotation_tool}" ${evaluated_annotation_args} # intended globbing
	;;
s) # drag to manually snip an area / click on a window to print it
	# shellcheck disable=SC2086
	grimblast copysave area $temp_screenshot && "${annotation_tool}" ${evaluated_annotation_args} ;; # intended globbing
sf)                                                                                                               # frozen screen, drag to manually snip an area / click on a window to print it
	# shellcheck disable=SC2086
	grimblast --freeze --cursor copysave area $temp_screenshot && "${annotation_tool}" ${evaluated_annotation_args} ;; # intended globbing
m)                                                                                                                                  # print focused monitor
	# timeout 0.2 slurp                                                                                                                  # capture animation lol
	# shellcheck disable=SC2086
	grimblast copysave output $temp_screenshot && "${annotation_tool}" ${evaluated_annotation_args} # intended globbing
	;;
*) # invalid option
	USAGE ;;
esac

[ -f "$temp_screenshot" ] && rm "$temp_screenshot"

if [ -f "${save_dir}/${save_file}" ]; then
	notify-send -a "Screenshot" -i "${save_dir}/${save_file}" "saved in ${save_dir}"
fi
