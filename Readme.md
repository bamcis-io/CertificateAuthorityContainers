# BAMCIS Certificate Authority Docker Containers

This repo contains Certificate Authority Docker Containers running both Alpine Linux and
Debian Linux using OpenJDK 8.

## Options

These containers will generally not be ready to use "as-is". You will need to create the container manually
specifying the information about the root CA certificate distinguished name such as Country, State, Location,
Organization, and Organizational Unit. The CN defaults to the container's host name. You can use the pre-generated
container that will use just the container's host name in generating the CA certificate that specific only a CN
is the certificate distinguished name.

## Details

The CA certificate is good for a default of 10 years, you can adjust this value with the `DAYS` build-arg.

The CA private key is encrypted with AES256 by a complex 128 character password that is stored as a persistent environment
variable available to the root user as `$CA_PRIVATE_KEY_PASSWORD` in its profile. The key is 4096 bits in length.

The CA Certificate is generated based on the input .conf file. It defaults to using 4096 bits and the SHA256 digest.

The generated CA certificate is added to the Java default keystore for trusted CAs.

## Usage

* Adjust the `ca.conf` file to suit your needs
* Run `.\build.ps1` in the ca-alpine or ca-debian directory with the appropriate arguments, for example:
	* `.\build.ps1 -Organization bamcis -OU bamcis.io -Country US`

This container is typically used as a base image for other containers that require SSL certificates, like MySQL or Apache.
You can use the CA certificate to generate SSL certs for those applications.
