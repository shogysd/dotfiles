function python_latest_stable_binpath
    for path in (find /Library/Frameworks/Python.framework/Versions/* -maxdepth 1 -name bin | sort -r)
        $path/python3 --version | awk -F ' ' '{print $NF}' | grep -e a -e b > /dev/null
        if [ ! $status -eq 0 ]
            echo $path
            break
        end
    end
end
