# A vagrant box of ubuntu 18.04 for CI - Ubuntu 18.04 minimal Vagrant Box using Ansible provisioner

**Current Ubuntu Version Used**: 18.04.2

**Pre-built Vagrant Box**:

  - [`vagrant init topinfra/ubuntu1804-ci`](https://vagrantcloud.com/topinfra/boxes/ubuntu1804-ci)


This example build configuration installs and configures Ubuntu 18.04 x86_64 minimal using Ansible, and then generates a Vagrant box file for VirtualBox.

The example can be modified to use more Ansible roles, plays, and included playbooks to fully configure (or partially) configure a box file suitable for deployment for development environments.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build the Vagrant box file:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/) (if you want to build the VirtualBox box)
  - [Ansible](http://docs.ansible.com/intro_installation.html)

## Usage

Make sure all the required software (listed above) is installed, then cd to the directory containing this README.md file, and run:

    $ packer build -force -var "version=1.0.0" -var "access_token=${VAGRANT_CLOUD_TOKEN}" ubuntu1804-ci.json
    $ vagrant box remove topinfra/ubuntu1804-ci
    $ vagrant box add builds/virtualbox-ubuntu1804-ci.box --name topinfra/ubuntu1804-ci

After a few minutes, Packer should tell you the box was generated successfully, and the box was uploaded to Vagrant Cloud.

> **Note**: This configuration includes a post-processor that pushes the built box to Vagrant Cloud (which requires a `VAGRANT_CLOUD_TOKEN` environment variable to be set); remove the `vagrant-cloud` post-processor from the Packer template to build the box locally and not push it to Vagrant Cloud. You don't need to specify a `version` variable either, if not using the `vagrant-cloud` post-processor.

## Testing built boxes

There's an included Vagrantfile that allows quick testing of the built Vagrant boxes. From this same directory, run the following command after building the box:

    $ vagrant up

## License

MIT license.
