# --- Image with *pre-installed* Kubric
# 
# docker run \
#   --rm \
#   --user $(id -u):$(id -g) \
#   --volume "$PWD:/kubric" \
#   --workdir "/kubric" \
#   --interactive \
#   kubricdockerhub/kubruntu:latest \
#   python3 examples/getting_started.py

FROM kubricdockerhub/blender:latest

WORKDIR /kubric

# --- Install Python dependencies
COPY requirements.txt .
RUN python3 -m ensurepip
RUN pip3 install --upgrade pip wheel
RUN pip3 install --upgrade --force-reinstall -r requirements.txt
RUN rm -f requirements.txt

# --- Silences tensorflow
ENV TF_CPP_MIN_LOG_LEVEL="3"

# --- Install Kubric
COPY dist/kubric*.whl .
RUN pip3 install `ls kubric*.whl`
RUN rm -f kubric*.whl
