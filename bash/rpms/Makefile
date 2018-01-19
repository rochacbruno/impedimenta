help:
	@echo 'Targets:'
	@echo '    help'
	@echo '        Show this message.'
	@echo '    clean'
	@echo '        Remove compiled files.'
	@echo '    lint'
	@echo '        Lint shell scripts.'
	@echo '    specfiles'
	@echo '        Create .spec files.'
	@echo '    srpms'
	@echo '        Create SRPM files from .spec files.'
	@echo '    rpms'
	@echo '        Create RPM files from SRPM files.'

clean:
	rm -rf specfiles srpms rpms

lint:
	shellcheck *.sh

specfiles:
	./gen-specfiles.sh --count 100 specfiles

srpms: specfiles
	./gen-srpms.sh srpms specfiles/*

rpms: srpms
	./gen-rpms.sh rpms srpms/*

.PHONY: help clean lint
