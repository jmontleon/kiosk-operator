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

Resolution sets the initial resolution. noVNC is capable of scaling and remote resizing.

And example kiosk CR:
```
apiVersion: kiosk.openshift.io/v1alpha1
kind: Kiosk
metadata:
  name: fedora-xfce
  namespace: kiosk
spec:
  additional_playbook_url: https://raw.githubusercontent.com/jmontleon/kiosk-operator/master/test-playbook.yml
  base_name: fedora-xfce
  count: 5
  desktop: Xfce
  distribution: fedora
  distribution_release: "31"
  passwd: password
  persistent_home: true
  persistent_home_delete_protection: true
  persistent_home_size: 5Gi
  resolution: 1024x768
  shell: bash
```

## Additional configuration
If you set `additional_playbook_url` the entrypoint script will attempt to download the ansible-playbook and run it.

## TODO
- Better Password mechanism
- set username and password per container if desired
