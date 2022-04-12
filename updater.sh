while getopts a: flag
do
    case "${flag}" in
        a) asset=${OPTARG};;
    esac
done

function update() {
	#---------------------------------------------Configure Here--------------------------------------------------
	# Replace in the url below the USER with the user of your repository and REPO with the name of the Repository
	#------------------------------------------------------------------------------------------------------------
	tag=$(curl "https://api.github.com/repos/USER/REPO/releases" | jq -r ".[0].tag_name")
	version=$(cat storage.json | jq -r ".config.version")
	if [ "$version" == "$tag" ]
	then
		echo "UP TO DATE"
	else
		bash beforeInstalling.sh
		wait

		#---------------------------------------------Configure Here--------------------------------------------------
		# Replace in the url below the USER with the user of your repository and REPO with the name of the Repository
		#------------------------------------------------------------------------------------------------------------
		echo $1
		LINK=$(curl "https://api.github.com/repos/USER/REPO/releases" | jq -r ".[0].assets[$asset].browser_download_url")
		wget $LINK
		jq -n --arg string "$tag" '{config: {version: $string}}' > storage.json

		bash afterInstalling.sh
		wait
	fi
}

function init() {
	FILE=storage.json
	if ! [ -f "$FILE" ]; then
		touch storage.json

		#---------------------------------------------Configure Here--------------------------------------------------
		# Replace in the url below the USER with the user of your repository and REPO with the name of the Repository
		#------------------------------------------------------------------------------------------------------------
		JSON=$(curl "https://api.github.com/repos/USER/REPO/releases" | jq -r ".[1].tag_name")
		jq -n --arg string "$JSON" '{config: {version: $string}}' > storage.json
	fi
}

init

while true; do update & sleep 60; done