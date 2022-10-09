\begin{equation}   
    min\sum_{j=1}^{n} f_j,\quad a_{j,1}>a_{j,2}>...>a_{j,n}
\end{equation}

$s.t.$
\begin{equation}   
    \sum_{j=1}^{i} a_{j,i}=1,\quad \forall i\le n
\end{equation}

\begin{equation}   
    \sum_{i=j}^{n} a_{j,i} < max\_item\_num,\quad \forall j \le max\_item\_num
\end{equation}

\begin{equation}   
    \sum_{i=j}^{n} S_ia_{j,i} < max\_item\_area,\quad \forall j\le n
\end{equation}

\begin{equation}   
\sum_{i=j+1}^{n} a_{j,i} \le (n-j)a_{j,j},\quad \forall j\le n-1
\end{equation}

\begin{equation}   
\sum_{i=j}^{n} a_{j,i} \le (n-j+1)a_{j,j},\quad \forall j\le n
\end{equation}


