//sethvoler @2021.05.17

void _strwrite(char *string)
{
  char *p_strdst = (char *)(0xb8000);
  while (*string)
  {

    *p_strdst = *string++; //指向显存的开始地址
    p_strdst += 2; // 跳过字符颜色信息
  }
  return;
}

void printf(char *fmt, ...)
{
  _strwrite(fmt);
  return;
}
