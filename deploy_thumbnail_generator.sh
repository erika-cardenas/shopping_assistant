# !bin/bash
gcloud config set project $PROJECT_ID

gcloud functions deploy thumbnail_v2 \
  --gen2 \
  --region=us-central1 \
  --runtime=python310 \
  --source=./src/request_thumbnail_image \
  --entry-point=http_create_thumbnail \
  --trigger-http \
  --allow-unauthenticated \
  --run-service-account=$FUNCTIONS_SERVICE_ACCOUNT \
  --set-env-vars=PROJECT_ID=$PROJECT_ID,BUCKET=$BUCKET

gcloud functions deploy create_thumbnail \
  --trigger-topic=$TOPIC \
  --gen2 \
  --region=us-central1 \
  --runtime=python310 \
  --source=./src/create_thumbnail_image \
  --entry-point=create_image \
  --allow-unauthenticated \
  --run-service-account=$FUNCTIONS_SERVICE_ACCOUNT \
  --set-env-vars=PROJECT_ID=$PROJECT_ID,BUCKET=$BUCKET