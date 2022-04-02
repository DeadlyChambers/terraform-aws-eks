# Build the docker images and push to the repository

_app_ver=$1
_app_proj=$2
_repo=$3
if [ -z "$_app_ver" ]
    then
        echo -e "Enter Version in the form of 6.0.1.8"
        read -p ": "  _app_ver
fi
if [ -z "$_app_proj" ]
    then
        echo "Do you wish to install this program?"
        select _app_proj in "data" "system"; do
            case $_app_proj in
                system ) break;;
                data ) exit;;
            esac
        done
fi

if [ -n "$_repo" ]
    then
        _repo="deadlychambers/soinshane-k8s"
    else
        aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/w7a3q5r
        _repo="public.ecr.aws/w7a3q5r4/soinshane/k8s"
fi

# Build the new images
docker build -t "$_repo-$_app_proj:$_app_ver" -t "$_repo-$_app_proj:latest" --build-arg APP_VER="$_app_ver" -f "$_app_proj.Dockerfile" .
# push the images
docker push "$_repo-$_app_proj" -a

