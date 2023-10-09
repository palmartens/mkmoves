echo "Building appplication"
npm run build
echo "Stopping container if running"
docker stop mkmoves
echo "Removing container"
docker rm mkmoves
echo "Updating image"
docker build -t mkmoves-server:v1 .
echo "Starting mkmoves container"
docker run -d --name mkmoves -p 8886:80 mkmoves-server:v1
echo "Done, server running at http://192.168.178.23:8886"
