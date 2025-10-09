.SILENT:
HOSTS = "*"
HOME_DIR?=${shell cd ~ && pwd}
GIT_DIR=${HOME_DIR}/git
WORK_DIR=${GIT_DIR}/gethomepage
GIT_REPO="https://github.com/gethomepage/homepage.git"
BRANCH="main"
SYS_DIR=${HOME_DIR}/.config/systemd/user

build:
	# This should be run when an big update happens
	cd ${WORK_DIR} && pnpm build

stop:
	echo "Stop"
	echo ${HOSTS}
	echo ${HOME_DIR}
	echo ${GIT_DIR}

setup:
	cd setup && sudo ./setup.sh

after-boot:
	git pull
	echo '|' >> ${WORK_DIR}/config/counter.txt
	cd files && cp * ${WORK_DIR}/config
	cd ${WORK_DIR} && HOMEPAGE_ALLOWED_HOSTS=${HOSTS} pnpm start &

clean:
	rm -rf ${WORK_DIR}
