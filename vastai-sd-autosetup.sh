#!/bin/bash
# Fully automated setup script for getting AUTOMATIC1111's Stable Diffusion Web GUI to run on Vast.ai
# Based on the following gist: https://gist.github.com/GabrielVidal1/b4a3b5c43614f6613508ab0114c65473

echo "Setting up variables..."
ROOT=/workspace
SD_DIR=sd
MODEL_DIR=$ROOT/$SD_DIR/models/Stable-diffusion
VENV=env
GRADIO_AUTH=user:password123 #Set the username and password to something strong
SD_REPO=https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
GDRIVE_ID=PUTYOURIDHERE #Use the ID from the model file's Google Drive share link

echo "Installing some packages and dependencies..."
apt update
apt install ffmpeg libsm6 libxext6 -y
pip install gdown moviepy==1.0.3

echo "Cloning Stable Diffusion repo..."
git clone $SD_REPO $ROOT/$SD_DIR

echo "Pulling the model..."
gdown $GDRIVE_ID -O $MODEL_DIR/

echo "Creating Python Virtual Environment..."
python3 -m venv $VENV
source $VENV/bin/activate

echo "Creating and running the launch script..."
cat << LAUNCH_SCRIPT > launch.sh
#!/bin/bash
export COMMANDLINE_ARGS="--share --gradio-auth=$GRADIO_AUTH --port=7860"
export REQS_FILE=requirements.txt
source $VENV/bin/activate
cd $ROOT/$SD_DIR
python3 launch.py
LAUNCH_SCRIPT
chmod +x launch.sh
./launch.sh
