#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>

void become_child() {
    int pid;
    pid = fork();
    if(pid < 0) exit(1);
    else if(pid > 0) exit(0);
}

void redirect_std_descriptors(char* logfile) {
    int nullfd;
    int logfd;
    nullfd = open("/dev/null", O_RDONLY);
    logfd = open(logfile, O_WRONLY|O_APPEND|O_CREAT, 0660);
    dup2(nullfd, STDIN_FILENO);
    dup2(logfd, STDOUT_FILENO);
    dup2(logfd, STDERR_FILENO);
    close(nullfd);
    close(logfd);
}

void write_pidfile(char* pidfile) {
    int pidfd;
    FILE* pidstream;
    pidfd = open(pidfile, O_WRONLY|O_TRUNC|O_CREAT, 0660);
    pidstream = fdopen(pidfd, "w");
    fprintf(pidstream, "%u\n", getpid());
    fclose(pidstream);
    close(pidfd);
}

void close_nonstd_descriptors() {
    int tempfd;
    for(tempfd = 3; tempfd <= sysconf(_SC_OPEN_MAX); tempfd++) {
        close(tempfd);
    }
}

void daemonize(char* logfile, char* pidfile) {
    become_child();
    setsid();
    become_child();
    redirect_std_descriptors(logfile);
    write_pidfile(pidfile);
    close_nonstd_descriptors(); 
}

int main(int argc,char** argv) {
    daemonize("daemon.log", "daemon.pid");

    while(1) {
        sleep(1);
    }

    return 0;
}

