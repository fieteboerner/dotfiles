# Customize the following:
containerName=$CONTAINER
phpunitPath=$REMOTE_PHPUNIT_BIN

# detect local path and remove from args
localPhpUnitResultPath='/tmp/phpunit-result.xml'
argsInput=${@}
runFile=$(echo $argsInput| awk '{print $1}')
phpTestPath=$(dirname "$runFile")
pushd $phpTestPath > /dev/null
projectPath="$(git rev-parse --show-toplevel | sed 's:/*$::')"
pushd > /dev/null

subPath=$(awk -F '/vendor/' '{print $1}' <<< $projectPath)
# containerName=$(sed 's#.*/##' <<< $subPath | sed s/-/_/g)

## detect test result output
filtered_args=()
for i in $argsInput; do
    case $i in
        --log-junit=*)
            outputPath="${i#*=}"
            ;;
        *)
            filtered_args+=("$i")
            ;;
    esac
done


# Detect path
container=$(docker ps -n=-1 --filter name=$containerName --format="{{.ID}}")
phpunitPath=$(docker exec -it $container /bin/bash -c "if [ -f vendor/bin/phpunit ]; then echo vendor/bin/phpunit; else echo bin/phpunit; fi" | tr -d '\r')
execPath=$(docker exec -it $container /bin/bash -c "if [ -f /bin/sh ]; then echo /bin/sh; else echo /bin/bash; fi" | tr -d '\r')
dockerPath=$(docker inspect --format {{.Config.WorkingDir}} $container | sed 's:/*$::')

# replace with local
args=("${filtered_args/$subPath/$dockerPath/}")
args=("${args//(*}")

## debug
# echo "Raw ARGS: "${@}
# echo "Params:   "${args[@]}
# echo "Docker:   "$dockerPath
# echo "Local:    "$projectPath
# echo "Result:   "$outputPath
# echo "Subpath:  "$subPath
# echo "docker exec -i "$container" php -d memory_limit=-1 "$phpunitPath" "${args[@]}

# Run the tests
# set -x
docker exec -it $container $execPath -c "SKIP_REFRESH_DB_STATE=1 $phpunitPath -d memory_limit=-1 -d xdebug.idekey=deliver-be ${args} --log-junit=${localPhpUnitResultPath}"
# set +x

# copy results
docker cp -a "$container:$localPhpUnitResultPath" "$outputPath"|- &> /dev/null

# replace docker path to locals
sed -i "s#$dockerPath#$projectPath#g" $outputPath

exit 0
