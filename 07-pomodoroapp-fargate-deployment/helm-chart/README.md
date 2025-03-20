# pomodoro-infra-configs
Infra configs for Promodoro Application

## Commands to deploy helm chart

Make sure you are inside helm-chart directory and deploy helm charts in below order.

### Deploy Report Backend

Modify the values.yaml file with your configuration and run the following command. Especially the mongourl under configmap template file data. If you change username and password in database, change it here as well.

```bash
helm install pomodoro-report-backend be-report-service -n be-pomodoro --create-namespace
```

### Deploy Backend

Modify the values.yaml file with your configuration and run the following command. Especially the values under configmap template file data.

Even though the frontend is not deployed, you have to give the frontend url. The base url will be your nodeip and nodeport you are going to expose the frontend. Same goes for report service url.

```bash
helm install pomodoro-backend be-pomodoro-app -n be-pomodoro --create-namespace
```

### Deploy Frontend

Modify the values.yaml file with your configuration and run the following command. Especially the values under configmap template file data.

```bash
helm install pomodoro-frontend fe-pomodoro-app -n fe-pomodoro --create-namespace
```

## Commands to deploy helm chart

If you no longer need the setup, run the following command to delete it.

### Frontend

```bash
helm delete pomodoro-frontend -n fe-pomodoro
```

### Backend
```bash
helm delete pomodoro-backend -n be-pomodoro
```

### Report Backend
```bash
helm delete pomodoro-report-backend -n be-pomodoro
```

### Database
```bash
helm delete pomodoro-db -n db-pomodoro
```
