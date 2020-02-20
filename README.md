# kiosk-operator
This operator will launch a set of containers accessible via noVNC.

## Getting the Kiosk Operator
`oc create -f kiosk-operator-source.yml`

## Installing Kiosk Operator
Navigate to OperatorHub in the OpenShift console and search for kiosk. Follow the menu for installation

## Deploying Kiosks
Either via the UI or CLI create a Kiosk resource.  Count determines how many container deployments will be launched. You can scale this up or down as desired.

Supported values for desktop are:
- fvwm
- i3
- KDE
- LXDE
- LXQt
- MATE
- Sugar
- Xfce

```
apiVersion: kiosk.openshift.io/v1alpha1
kind: Kiosk
metadata:
  name: fedora-xfce
  namespace: kiosk
spec:
  additional_playbook_url: ""
  base_name: fedora-xfce
  count: 1
  desktop: Xfce
  distribution: fedora
  passwd: password
  persistent_home: false
  persistent_home_size: 5Gi
  release: "31"
  resolution: 1024x768
  shell: bash
```

## TODO
- Fix hard coded `kiosk` namespace
- Better Password mechanism
- set username and password per container if desired
- make pvcs optional for real
- implement running optional ansible playbook
