Name:      100-files
Version:   1
Release:   1%{?dist}
Summary:   One hundred files.
License:   Public Domain
URL:       https://github.com/PulpQE/pulp-fixtures
BuildArch: noarch

%description
One hundred files. Useful for basic testing of applications or tools that manage
RPM files, such as Pulp.

%prep

%build
# rpmbuild cd's to the BUILD dir at the beginning of the build and install
# steps.
for i in {1..100}; do
    touch "${i}"
done

%install
mkdir -p %{buildroot}/opt/%{name}
cp -t %{buildroot}/opt/%{name} *

%files
# Must be absolute paths.
/opt/%{name}
