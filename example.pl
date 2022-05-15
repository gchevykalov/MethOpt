% ������������, ��� x �� S.
belong(x,s,fact).

% ������������, ��� y �� co(S).
belong(y,co,fact).

% ������������, ��� z �� U.
belong(z,u,fact).

% �������, ����������� ���������, ����������� �� X ��������� S.
belong(X,s,rule):-
   (   belong(X,s,fact),!,
                     % ^ ��������� ���������, ��������� ���������� ������ ���������, ���� �� ����� ����. (� ������� ������
                     % belong(X,s,fact) ���������� ������� true, ���� ���� ����, ����� ���������� ���������� true
                     % ������� ���, ������� ����� ���� ���������. � ����� ������ ������������ false. ���� ������ ����� ���,
                     % ������ ������������ false).
       write(X),
       write(' ����������� ��������� s �� �������������.\n')   );
   (   write('�������� �������� ��������� '),
       write(X),
       write('.\n'),
       discrete_coords_values(X,List), % �������� ������ ��������� �������� ��������� X � ��������� �� ����������� S.
       length(List,List_length),
       List_length == 2,
       List = [Head|Tail],
       abs(Head,Abs_head),
       Abs_head == 1,
       Tail = [Tail_head],
       abs(Tail_head,Abs_tail),
       Abs_tail == 1,
       write(X),
       write(' ����������� ��������� s �� ����������� s.\n')   ).

% �������, ����������� ���������, ����������� �� X ��������� U.
belong(X,u,rule):-
    (   belong(X,u,fact),!,
                       % ^ ��������� ���������, ��������� ���������� ������ ���������, ���� �� ����� ����.
        write(X),
        write(' ����������� ��������� u �� �������������.\n')   );
    (   write('������ �������� ��������� '),
        write(X),
        write('.\n'),
        coords_values(X,Max,Min), % �������� �������� �������� ��������� X � ��������� �� ����������� U.
        Max =< 1,
        Min >= -1,
        write(X),
        write(' ����������� ��������� u �� ����������� u.\n')   ).

% �������, ����������� ���������, ����������� �� X ��������� co(S).
belong(X,co,rule):-
    (   belong(X,co,fact),!,
                        % ^ ��������� ���������, ��������� ���������� ������ ���������, ���� �� ����� ����.
        write(X),
        write(' ����������� ��������� co(s) �� �������������.\n')   );
    (   write('�������� ����� �� ����������� '),
        write(X),
        write(' � ���� �������� ���������� ��������� �� s.\n'),
        convex_combination(X,s), % ���������, ����� �� ����������� X ��� �������� ���������� ��������� �� S.
        write(X),
        write(' ����������� ��������� co(s) �� ����������� co(s).\n')   ).

% ������� ����������� ��������� ���������� �������� A � B.
% ������ �������� ����� ����������� � �������� ����� �����.
equals(A,B):-
    (   write('������� '),
        belong(X,A,fact),!,
                       % ^ ��������� ���������, ��������� ���������� ������� ���� x.
        write(X),
        write(' �� '),
        write(A),
        write(' � �������� ��� �������������� ��������� '),
        write(B),
        write('.\n'),
        belong(X,B,rule),
        write('����������� ��������� '),
        write(A),
        write(' � '),
        write(B),
        write('.\n\n'),
        write('������ ������� '),
        belong(Y,B,fact),!,
                       % ^ ��������� ���������, ��������� ���������� ������� ���� y.
        write(Y),
        write(' �� '),
        write(B),
        write(' � �������� ��� �������������� ��������� '),
        write(A),
        write('.\n'),
        belong(Y,A,rule),
        write('����������� ��������� '),
        write(B),
        write(' � '),
        write(A),
        write('.\n')   ).

% ����� ��������� �������� ��������� x ������ �����������.
% (������������ ��������, � ������ X �� S, �� ������ ������� ������ ���
% ���������� �����������). ���� X �� �� S, U ��� co(S), �� �������
% ���������� ������ �� �����.
coords_values(X,Max,Min):-
    (   ((   belong(X,s,fact),
             write('��������� �������� ��������� �� ����������� s.\n')   );
         (   belong(X,u,fact),
             write('��������� �������� ��������� �� ����������� u.\n')   )),!,
                                                                          % ^ ��������� ���������, ��������� ����������
                                                                          % ������ ���������, ���� �� ����� ����.
        Max is 1,   % �������� �������� �� ����������� S � U.
        Min is -1   );
    (   belong(X,co,fact),!,
                        % ^ ��������� ���������, ��������� ���������� ������ ���������, ���� �� ����� ����.
        write('��������� �������� ��������� �� ����������� co(s).\n'),
        combination_values(Comb_max,Comb_min,lambda,s),
        Max is Comb_max,  % �������� �������� �� ����������� co(S).
        Min is Comb_min   ).

% ������ ��������� �������� ��������� X (��������� ������ ���� ���������
% �������� �������� �����).
discrete_coords_values(X,List):-
    (   belong(X,s,fact),!,
                       % ^ ��������� ���������, ��������� ���������� ������ ���������, ���� �� ����� ����.
        write('�������� ������ ��������� �������� ��������� �� ����������� s.\n'),
        List = [-1, 1]   ).

% ��� ������ ������ ���� ����� 0.
not_negative(lambda).

% ����� ���� ����� ����� 1.
sum_all(lambda,Sum):-
    Sum is 1.

% � ������, ���� ��� �������� ����� ������������, ������������ ���������
% ����� �� ����������� ���� �����. � ��������� ������, ���
% �������������� ��������� ������� ������ ������.
upper_sum_part(X,Sum):-
    (   not_negative(X),
        write('������������� ������������������ '),
        write(X),
        write(', ����� ������� ���������� �������� ����� �����.\n'),
        sum_all(X,Sum_all),
        Sum is Sum_all   ).

% � ������, ���� ��� �������� ����� ������������, ����������� ���������
% ����� �� ������ 0. � ��������� ������, ��� �������������� ���������
% ������� ������ ������.
lower_sum_part(X,Sum):-
    (   not_negative(X),
        write('������������� ������������������ '),
        write(X),
        write(', ����� ������� ���������� �������� ����� �����.\n'),
        Sum is 0   ).

% ��������� ����� �� ����������� ������� X �������� �����������
% ��������� �� B. ��������� ������ ��� B � ����������� ������������� ��
% ����������.
convex_combination(X,B):-
    (   belong(Y,B,fact),!,
                       % ^ ��������� ���������, ��������� ���������� ������� ���� y.
        coords_values(Y,Y_max,Y_min),
        coords_values(X,X_max,X_min),
        try_build_convex_combination(X_max,X_min,Y_max,Y_min)   ).

% ������ �������� �������� ���������� sum(Coefs[i]*x[i]), ��� x �� A.
combination_values(Max,Min,Coefs,A):-
    (   belong(X,A,fact),!,
                       % ^ ��������� ���������, ��������� ���������� ������� ���� x.
        upper_sum_part(Coefs,Upper_sum),
        lower_sum_part(Coefs,Lower_sum),
        coords_values(X,Coords_max,Coords_min),
        List = [Upper_sum * Coords_max,Upper_sum * Coords_min,
               Lower_sum * Coords_max,Lower_sum * Coords_min],
        max_list(List,Max),
        min_list(List,Min)   ).

% �������� ������� �������� ���������� �� ������ ���������� ��������
% ���������.
try_build_convex_combination(X_max,X_min,Y_max,Y_min):-
    (   Y_max >= X_max,
        Y_min =< X_min,
        combinate_by_num_coord('n',X_max,X_min,Y_max,Y_min),!   ).
                                                          % ^ ��������� ���������, ��������� �� ����� ���������
                                                          % ��� ��������� ������ ��������.

% ����� �������� ��� �������� ������������� �������� ��������
% �����������, ��������� �� ��������� ��������.
combinate_by_num_coord(Num,X_max,X_min,Y_max,Y_min):-
    (   Num == 'm-1',
        write('��� m-1 ������ �������������.\n')   );
    (   Num == '1',
        write('�������� ��� 1.\n'),
        evaluate_coef(X_max,X_min,Y_max,Y_min,Min,Max,Sum),
        Min >= 0,
        Max =< 1,
        Sum == 1   );
    (   Num == 'm',
        write('������������� ������� ��������: �� ������ ���� �������� �������� �� ���� ���������� ������.\n'),
        combinate_by_num_coord('1',X_max,X_min,Y_max,Y_min),
        combinate_by_num_coord('m-1',X_max,X_min,Y_max,Y_min),
        write('������� ������� �� m-1 � m.\n'),
        evaluate_coefs_in_comb_of_comb(X_max,X_min,Y_max,Y_min,0,1,Comb_min,Comb_sum),
        Comb_min >= 0,
        Comb_sum == 1   );
    (   combinate_by_num_coord('m',X_max,X_min,Y_max,Y_min),
        write('��������� ������� �������� ��������, ��� ����� ��� ������ m, �� ����� � ��� '),
        write(Num),
        write('.\n')   ).

% ������ ������������� � ����������.
evaluate_coef(X_max,X_min,Y_max,Y_min,Min,Max,Sum):-
    (   write('������������� �������������� t=(1-alpha)*t_1+alpha*t_2, ��� aplha ������������ �� �������: (1-alpha)*a+alpha*b=x. ��� ��������� ��������� ������� �������, �� ������� ������.\n'),
        Sum is 1,
        List = [(Y_max - X_max)/(Y_max - Y_min),(X_max - Y_min)/(Y_max - Y_min),
               (Y_max - X_min)/(Y_max - Y_min),(X_min - Y_min)/(Y_max - Y_min)],
        max_list(List,Max),
        min_list(List,Min)   ).

% ������ ����������� � ���������� ����������.
evaluate_coefs_in_comb_of_comb(X_max,X_min,Y_max,Y_min,Out_min,Out_sum,Comb_min,Comb_sum):-
    (   write('�������� �������� ���������� �������� ����������. ��� ���� ����� �� ���������� ����������� �������� ��������, ������������ ������ � ����� ����������.\n'),
        evaluate_coef(X_max,X_min,Y_max,Y_min,Min,Max,Sum),
        Comb_sum is Sum * Out_sum,
        (Out_min < 0,
        Comb_min is Out_min * Max;
        Comb_min is Out_min * Min)   ).
