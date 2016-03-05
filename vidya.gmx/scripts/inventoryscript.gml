///query_database(item number, info type)
switch(argument0)
{
case 4:
    switch(argument1)
    {
    case 0:
        return "Trusty Sword"
    break;
    case 1:
        return "Durable. Reliable. Sharp. It's never failed you."
    break;
    case 2:
        return 0 //item type 0 = noninteractable 1 = head 2 = hand 3 armor
    break;
    default:
        return "idk the query bro lol"
    break;
    }
case 2:
    switch(argument1)
    {
    case 0:
        return "Trusty Sword"
    break;
    case 1:
        return "Durable. Reliable. Sharp. It's never failed you."
    break;
    case 2:
        return 1 //item type 0 = noninteractable 1 = head 2 = hand 3 armor
    break;
    default:
        return "idk the query bro lol"
    break;
    }
case 3:
    switch(argument1)
    {
    case 0:
        return "Trusty Sword"
    break;
    case 1:
        return "Durable. Reliable. Sharp. It's never failed you."
    break;
    case 2:
        return 3 //item type 0 = noninteractable 1 = head 2 = hand 3 armor
    break;
    default:
        return "idk the query bro lol"
    break;
    }
case 1:
    switch(argument1)
    {
    case 0:
        return "Trusty Sword"
    break;
    case 1:
        return "Durable. Reliable. Sharp. It's never failed you."
    break;
    case 2:
        return 2 //item type 0 = noninteractable 1 = head 2 = hand 3 armor
    break;
    default:
        return "idk the query bro lol"
    break;
    }
default:
    switch(argument1)
    {
    case 0:
        return "Trusty Shield"
    break;
    case 1:
        return "Basic round buckler. It'll block anything (within reason,) but it's not remarkable in anyway."
    break;
    case 2:
        return 2 //item type 0 = noninteractable 1 = head 2 = hand 3 armor
    break;
    default:
        return "idk the query bro lol"
    break;
    }
break;
}
