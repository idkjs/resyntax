#!/bin/sh

# deleting converted files
Delete(){
    RE() {
        filenames=$(find "$(pwd)" -name "*.re")
        len=${#filenames[@]}
        echo "$len"
        echo "$filenames"
        for filename in $filenames; do rm "$filename"; done;
        exit 0
    }

    REI() {
        filenames=$(find "$(pwd)" -name "*.rei")
        len=${#filenames[@]}
        echo "$len"
        echo "$filenames"
        for filename in $filenames; do rm "$filename"; done;
        exit 0
    }

    ML() {
        filenames=$(find "$(pwd)" -name "*.ml")
        len=${#filenames[@]}
        echo "$len"
        echo "$filenames"
        for filename in $filenames; do rm "$filename"; done;
        exit 0
    }

    RES() {
        filenames=$(find "$(pwd)" -name "*.res")
        len=${#filenames[@]}
        echo "$len"
        echo "$filenames"
        for filename in $filenames; do rm "$filename"; done;
        exit 0

    }

    MLI() {
        filenames=$(find "$(pwd)" -name "*.mli")
        len=${#filenames[@]}
        echo "$len"
        echo "$filenames"
        for filename in $filenames; do rm "$filename"; done;
        exit 0
    }
    RESI() {
        filenames=$(find "$(pwd)" -name "*.resi")
        len=${#filenames[@]}
        echo "$len"
        echo "$filenames"
        for filename in $filenames; do rm "$filename"; done;
        exit 0
    }

    run(){
        echo "Which files do you want to delete?"
        # shellcheck disable=SC2039
        select result in .re .rei .res .resi .ml .mli None Exit
        do
            if [ "$result" = "Exit" ]; then
                echo "$result"
                exit 0
            fi
            if [ "$result" = "None" ]; then
                echo "$result"
                exit 0
            fi
            if [ "$result" = ".res" ]; then
                echo "$result"
                RES
                exit 0
            fi
            if [ "$result" = ".resi" ]; then
                echo "$result"
                RESI
                exit 0
            fi
            if [ "$result" = ".re" ]; then
                echo "$result"
                RE
                exit 0
            fi
            if [ "$result" = ".rei" ]; then
                echo "$result"
                REI
                exit 0
            fi
            if [ "$result" = ".ml" ]; then
                echo "$result"
                ML
                exit 0
            fi
            if [ "$result" = ".mli" ]; then
                echo "$result"
                MLI
                exit 0
                # else
                #     exit
            fi
            echo $result
        done
    }
    run
}
# bsrefmt
check_opam_bsrefmt(){
    if ! (which bsrefmt >/dev/null 2>&1)
    then
        echo "please install bsrefmt with opam or npm install bs-platform"
        exit
    fi
}
check_bsplatform(){
    bin_bsrefmt=$(command -v "$(pwd)"/node_modules/.bin/bsrefmt)

    if ! (command -v "$bin_bsrefmt" >/dev/null 2>&1)
    then
        echo "please install bs-platform with npm or yarn"
        exit
    fi
}

REtoRes() {
    check_bsplatform

    filenames=$(find "$(pwd)" -name "*.re")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do npx bsc -format "$filename" > "${filename%.re}.res"; done;
    Delete
    # exit 0

}
REStoRE() {
    check_bsplatform

    filenames=$(find "$(pwd)" -name "*.res")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do npx bsc -format "$filename" > "${filename%.res}.re"; done;
    exit 0
}
RESItoREI() {
    check_bsplatform
    filenames=$(find "$(pwd)" -name "*.resi")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do npx bsc -format "$filename" > "${filename%.resi}.rei"; done;
    exit 0
}
REItoResi() {
    check_bsplatform
    filenames=$(find "$(pwd)" -name "*.rei")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do npx bsc -format "$filename" > "${filename%.rei}.resi"; done;
    exit 0
}

MLtoRE() {
    check_opam_bsrefmt
    filenames=$(find "$(pwd)" -name "*.ml")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do bsrefmt --parse ml --print re "$filename" > "${filename%.ml}.re"; done;
    exit 0
}

REtoML() {
    check_opam_bsrefmt
    filenames=$(find "$(pwd)" -name "*.re")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do bsrefmt --parse re --print ml "$filename" > "${filename%.re}.ml"; done;
    exit 0

}

MLItoREI() {
    check_opam_bsrefmt
    filenames=$(find "$(pwd)" -name "*.mli")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do bsrefmt --parse ml --print re "$filename" > "${filename%.mli}.rei"; done;
    exit 0
}
REItoMLI() {
    check_opam_bsrefmt
    filenames=$(find "$(pwd)" -name "*.rei")
    len=${#filenames[@]}
    echo "$len"
    echo "$filenames"
    for filename in $filenames; do bsrefmt --parse re --print ml "$filename" > "${filename%.rei}.mli"; done;
    exit 0
}

run(){
    echo "Which files do you want to migrate?"
    # shellcheck disable=SC2039
    select result in REtoRes REItoResi REStoRE RESItoREI MLtoRE MLItoREI REtoML REItoMLI REStoRe Delete Cancel Exit
    do
        if [ "$result" = "Exit" ]; then
            echo "$result"
            exit 0
        fi
        if [ "$result" = "Delete" ]; then
            echo "$result"
            Delete
            # exit 0
        fi
        if [ "$result" = "Cancel" ]; then
            echo "$result"
            exit 1
        fi
        if [ "$result" = "REtoRes" ]; then
            echo "$result"
            REtoRes
            exit 0
        fi
        if [ "$result" = "REItoResi" ]; then
            echo "$result"
            REItoResi
            exit 0
        fi
        if [ "$result" = "REStoRE" ]; then
            echo "$result"
            REStoRE
            exit 0
        fi
        if [ "$result" = "RESItoREI" ]; then
            echo "$result"
            RESItoREI
            exit 0
        fi
        if [ "$result" = "REtoML" ]; then
            echo "$result"
            REtoML
            exit 0
        fi
        if [ "$result" = "REItoMLI" ]; then
            echo "$result"
            REItoMLI
            exit 0
        fi
        if [ "$result" = "MLtoRE" ]; then
            echo "$result"
            MLtoRE
            exit 0
        fi
        if [ "$result" = "MLItoREI" ]; then
            echo "$result"
            MLItoREI
            exit 0
            # else
            #     exit
        fi
        echo $result
    done
}
run
