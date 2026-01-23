# FPT

Host git-fpt
    HostName git.fptshop.com.vn
    User git
    IdentityFile ~/.ssh/id_ed25519_git_quocnhv_frt
    IdentitiesOnly yes

Host git2-fpt
    HostName git2.fptshop.com.vn
    User git
    IdentityFile ~/.ssh/id_ed25519_git2_quocnhv_frt
    IdentitiesOnly yes

Host frt-spark-master-dev
    Hostname 127.0.0.1
    IdentityFile ~/.ssh/id_ed25519_quocnhv_frt_spark
    User root
    Port 30004
    StrictHostKeyChecking no
    ControlMaster auto
    ControlPath ~/.ssh/%r@%h:%p
    ControlPersist 1
