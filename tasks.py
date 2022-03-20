from invoke import task

@task
def install_requirements(c, force=False):
    force_cmd = "--force" if force else ""
    c.run(f"ansible-galaxy install -r requirements.yml {force_cmd}", pty=True)

@task
def playbook_run(c, security=False):
    security_cmd = "--skip-tags security" if not security else ""
    c.run(
        f"""
            ansible-playbook -i hosts playbook.yml \
                --private-key ~/.ssh/id_rsa \
                --diff \
                {security_cmd}
        """,
        pty=True,
    )
