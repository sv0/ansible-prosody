import pytest
import os
import yaml
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


@pytest.fixture()
def AnsibleDefaults():
    with open("defaults/main.yml", 'r') as stream:
        return yaml.load(stream)


@pytest.mark.parametrize("dirs", [
    "/etc/prosody",
])
def test_directories(host, dirs):
    d = host.file(dirs)
    assert d.is_directory
    assert d.exists


@pytest.mark.parametrize("files", [
    '/etc/apt/trusted.gpg.d/prosody.gpg',
    '/etc/systemd/system/prosody.service',
    '/etc/prosody/prosody.cfg.lua',
])
def test_files(host, files):
    f = host.file(files)
    assert f.exists
    assert f.is_file


def test_user(host):
    assert host.group("prosody").exists
    assert host.user("prosody").exists


@pytest.mark.parametrize("service", [
    "prosody",
])
def test_service(host, service):
    s = host.service(service)
    assert s.is_enabled
    assert s.is_running


@pytest.mark.parametrize("port", [5222, 5269])
def test_socket(host, port):
    s = host.socket(f"tcp://0.0.0.0:{port}")
    assert s.is_listening


# def test_version(host, AnsibleDefaults):
#     version = os.getenv('PROMETHEUS', AnsibleDefaults['prometheus_version'])
#     run = host.run("/usr/local/bin/prometheus --version")
#     out = run.stdout+run.stderr
#     assert "prometheus, version " + version in out
