unit interf.iterator;

interface

type
  IIterator<T: class> = interface
    ['{5EEB921E-1939-4887-B070-860163561583}']
    function MoveNext: Boolean; // Avança para o próximo item
    function GetCurrent: T; // Retorna o item atual
    property Current: T read GetCurrent; // Propriedade para acessar o item atual
    function GetEnumerator: IIterator<T>;
  end;


implementation



end.
