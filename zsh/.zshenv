# Neovim Intel
if [[ -d "/opt/nvim/nvim-linux-x86_64/bin" && -f "/opt/nvim/nvim-linux-x86_64/bin/nvim" ]]; then
    export PATH=$PATH:/opt/nvim/nvim-linux-x86_64/bin
fi

# Linux
if [[ "$OS" == "ubuntu" ]]; then
    # Cargo
    export PATH="$HOME/.cargo/bin:$PATH"

    # JAVA
    export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
    export PATH=$PATH:$JAVA_HOME/bin
    # export JAVA_OPTS="$JAVA_OPTS -Dhttp.proxyHost=10.5.33.2 -Dhttp.proxyPort=6777 -Dhttp.proxyUser=alan1 -Dhttp.proxyPassword=xe&UvMTrrEOiPhA7"

    # Coursier
    export PATH="$PATH:/home/$USER/.local/share/coursier/bin"

    # Maven
    export MAVEN_HOME=/opt/maven/apache-maven-3.9.9
    export PATH=$PATH:$MAVEN_HOME/bin

    # Hadoop
    # ...

    # Kafka
    # ...

    # Spark
    export SPARK_HOME=/opt/spark/spark-3.5.4-bin-hadoop3-scala2.13
    export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.7-src.zip:$PYTHONPATH
    export PATH=$SPARK_HOME/bin:$SPARK_HOME/python:$PATH

    # DuckDB
    export PATH="$HOME/.duckdb/cli/latest':$PATH"
fi
