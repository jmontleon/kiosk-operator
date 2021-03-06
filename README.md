# kiosk-operator
This operator will launch a set of containers accessible via noVNC.

An Xfce desktop session running in a container on OpenShift 4:
![Xfce Desktop](https://github.com/jmontleon/kiosk-operator/blob/master/fedora-xfce.png)

Just 1 of 5 containers launched with a single CR.
```
$ oc get po
NAME                              READY   STATUS    RESTARTS   AGE
fedora-xfce-1-7c694bb859-xzrxb    2/2     Running   0          25m
fedora-xfce-2-57bbc95cc5-t5tms    2/2     Running   0          25m
fedora-xfce-3-746bb7875-2xmv8     2/2     Running   0          25m
fedora-xfce-4-5d8dbc6df5-sbm22    2/2     Running   0          25m
fedora-xfce-5-77c77c9b99-r6h9v    2/2     Running   0          25m
kiosk-operator-7dcfd784b7-7h6s8   2/2     Running   0          48m
```

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

## Per Container Credentials
You can construct a set of credentials in the spec like so if desired. If the count is greater than the set of credentials containers will fall back to the user 'vnc' and the value specified in the `passwd` parameter.

```
spec:
  credentials:
  - count: 1
    passwd: onecat!!
    user: student1
  - count: 2
    passwd: twodogs!
    user: student2
```


## TODO
- Better Password mechanism
- Smaller more discrete images? 7GiB is... big.
- Move most of vnc.sh to a playbook
