DEV_ROCKS = "lua-cjson 2.1.0" "kong 0.14.0" "luacov 0.12.0" "busted 2.0.rc12" "luacov-cobertura 0.2-1" "luacheck 0.20.0"
PROJECT_FOLDER = kong/plugins/request-morph
LUA_PROJECT = request-morph


mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))
DEV_PACKAGE_PATH := $(current_dir)lua_modules/share/lua/5.1/?


define set_env
	@eval $$(luarocks path); \
	LUA_PATH="$(DEV_PACKAGE_PATH).lua;$$LUA_PATH" LUA_CPATH="$(DEV_PACKAGE_PATH).so;$$LUA_CPATH";
endef

setup:
	cd $(PROJECT_FOLDER)
	luarocks install --server=http://luarocks.org/dev luaffi
	luarocks install luabitop 1.0.1
	luarocks install luasec 0.6 OPENSSL_DIR=/usr/local/opt/openssl
	luarocks install luaossl 20171028 OPENSSL_DIR=/usr/local/opt/openssl CRYPTO_DIR=/usr/local/opt/openssl
	@for rock in $(DEV_ROCKS) ; do \
		if luarocks list --porcelain $$rock | grep -q "installed" ; then \
			echo $$rock already installed, skipping ; \
		else \
			echo $$rock not found, installing via luarocks... ; \
			luarocks install $$rock; \
		fi \
	done;

	

check:
	cd $(PROJECT_FOLDER)
	@for rock in $(DEV_ROCKS) ; do \
		if luarocks list --porcelain $$rock | grep -q "installed" ; then \
			echo $$rock is installed ; \
		else \
			echo $$rock is not installed ; \
		fi \
	done;

install:
	-@luarocks remove $(LUA_PROJECT)
	luarocks make

test:
	$(call set_env) \
	cd $(PROJECT_FOLDER) && busted spec/ ${ARGS}

coverage:
	cd $(PROJECT_FOLDER) && busted spec/ -c && luacov && luacov-cobertura -o cobertura.xml

package:
	luarocks make --pack-binary-rock

lint:
	cd $(PROJECT_FOLDER) && luacheck -q .